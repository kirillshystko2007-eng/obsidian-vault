-- SPURS CLIENT (2026-11-27, realism update). Deputy spurs with physics-based sound:
-- - Rowel CLICKS (wheel hitting ground/staple) + Jinglebob CHIMES (dangling weights)
-- - Rowel inertia: slow = distinct clicks, fast = free-spin rattle
-- - Surface EQ: dirt/wood/stone/metal change the tone
-- - Left/right asymmetry (manufacturing tolerances)
-- - Leather strap creak under load
-- - Load-aware pitch (bag weight affects tone)
-- 2026-11-27: synced with FootPlant (animation-accurate foot plants), RetroFootsteps.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")

local FootPlant = require(ReplicatedStorage:WaitForChild("FootPlant"))
local MoveSpeed = require(ReplicatedStorage:WaitForChild("MoveSpeed"))
local player = Players.LocalPlayer

-- === SOUND ASSETS (v2 spur jingles + new click layer) ===
-- spur_click_1..3 = rowel tooth striking staple/ground (sharp, short)
-- spur_jingle_1..3 = jinglebob chimes (tonal, longer decay)
-- spur_rattle = sustained rowel free-spin (sprint only)
local SOUND_CLICK = {
	"rbxassetid://131028729090994", -- reuse v2 click-like
	"rbxassetid://103864595231751",
	"rbxassetid://115348889021728",
}
local SOUND_JINGLE = {
	"rbxassetid://131028729090994", -- same assets, played differently
	"rbxassetid://103864595231751",
	"rbxassetid://115348889021728",
}
local SOUND_RATTLE = "rbxassetid://115348889021728" -- fast rattle layer

-- === TUNABLES ===
local BASE_VOLUME_CLICK = 0.45
local BASE_VOLUME_JINGLE = 0.28
local BASE_VOLUME_RATTLE = 0.18
local HEAR_RANGE = 80
local ROWEL_NOTCH = math.rad(30) -- 12 teeth

-- Rowel physics: angular velocity (rad/s) decays with drag, step imparts impulse
local ROWEL_DRAG = 4.5          -- viscous drag (free-spin decay)
local ROWEL_IMPULSE_WALK = 18   -- rad/s added per step (walk)
local ROWEL_IMPULSE_RUN = 35    -- rad/s added per step (sprint)
local RATTLE_THRESHOLD = 25     -- rad/s above which rowel "chatters" (free-spin)
local CLICK_MIN_GAP = 0.055     -- s between distinct clicks (prevents double-trigger)

-- Surface EQ multipliers (applied to click/jingle volumes)
local SURFACE_EQ = {
	[Enum.Material.Sand]      = { click = 0.85, jingle = 0.95, pitch = 1.02 }, -- softer, slightly brighter
	[Enum.Material.Ground]    = { click = 0.95, jingle = 1.0,  pitch = 1.0  },
	[Enum.Material.Grass]     = { click = 0.7,  jingle = 0.9,  pitch = 1.05 },
	[Enum.Material.Dirt]      = { click = 0.9,  jingle = 1.0,  pitch = 1.0  },
	[Enum.Material.Rock]      = { click = 1.15, jingle = 1.05, pitch = 0.95 }, -- harder, brighter click
	[Enum.Material.Basalt]    = { click = 1.15, jingle = 1.05, pitch = 0.95 },
	[Enum.Material.Slate]     = { click = 1.15, jingle = 1.05, pitch = 0.95 },
	[Enum.Material.Cobblestone]= { click = 1.2,  jingle = 1.1,  pitch = 0.92 },
	[Enum.Material.Brick]     = { click = 1.15, jingle = 1.05, pitch = 0.95 },
	[Enum.Material.Concrete]  = { click = 1.2,  jingle = 1.1,  pitch = 0.92 },
	[Enum.Material.Wood]      = { click = 0.8,  jingle = 1.15, pitch = 1.08 }, -- duller click, richer chime
	[Enum.Material.WoodPlanks]= { click = 0.8,  jingle = 1.15, pitch = 1.08 },
	[Enum.Material.Metal]     = { click = 1.3,  jingle = 1.25, pitch = 0.88 }, -- loud, ringing
	[Enum.Material.DiamondPlate]= { click = 1.3,  jingle = 1.25, pitch = 0.88 },
	[Enum.Material.CorrodedMetal]={ click = 1.25, jingle = 1.2,  pitch = 0.9 },
}
local DEFAULT_SURFACE = { click = 1.0, jingle = 1.0, pitch = 1.0 }

-- Left/right asymmetry (each spur is slightly different)
local rng = Random.new()
local function asym() return 1 + rng:NextNumber(-0.035, 0.035) end

local tracked = {} -- [character] = entry

-- Preload all sounds
task.spawn(function()
	local list = {}
	for _, id in ipairs(SOUND_CLICK) do
		local s = Instance.new("Sound"); s.SoundId = id; table.insert(list, s)
	end
	for _, id in ipairs(SOUND_JINGLE) do
		local s = Instance.new("Sound"); s.SoundId = id; table.insert(list, s)
	end
	local sr = Instance.new("Sound"); sr.SoundId = SOUND_RATTLE; table.insert(list, sr)
	pcall(function() ContentProvider:PreloadAsync(list) end)
end)

local function silent(entry)
	local owner = Players:GetPlayerFromCharacter(entry.character)
	if owner and owner:GetAttribute("Ghost") == true then return true end
	return entry.humanoid.Health <= 0
end

-- Get or create sound instances on a rowel
local function soundFor(rowel, name, soundId)
	local s = rowel:FindFirstChild(name)
	if not s then
		s = Instance.new("Sound")
		s.Name = name
		s.SoundId = soundId
		s.RollOffMode = Enum.RollOffMode.InverseTapered
		s.RollOffMinDistance = 4
		s.RollOffMaxDistance = 60
		s.Parent = rowel
	end
	return s
end

-- Get surface material under a character's foot
local function getFootMaterial(character, side)
	local leg = character:FindFirstChild(side .. " Leg")
	if not leg then return nil end
	-- Raycast down from foot bottom
	local root = character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end
	local footBottom = (leg.CFrame * CFrame.new(0, -leg.Size.Y/2, 0)).Position
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = { character }
	params.IgnoreWater = true
	local hit = workspace:Raycast(footBottom, Vector3.new(0, -3, 0), params)
	if hit then return hit.Material end
	-- Fallback: FloorMaterial of local humanoid (only accurate for own character)
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum and hum.FloorMaterial ~= Enum.Material.Air then return hum.FloorMaterial end
	return nil
end

-- Get load factor from bag contents (0 = empty, 1 = full 6/6 slots)
local function getLoadFactor(character)
	local owner = Players:GetPlayerFromCharacter(character)
	if not owner then return 0 end
	local bag = owner:FindFirstChild("Backpack") and owner.Backpack:FindFirstChild("Bag")
	if not bag then return 0 end
	local count = 0
	for _, tool in ipairs(bag:GetChildren()) do
		if tool:IsA("Tool") then count += 1 end
	end
	return math.clamp(count / 6, 0, 1)
end

-- Main step handler
local function onStep(entry, side, info)
	if not entry.spurs.Parent or silent(entry) then return end

	local camera = workspace.CurrentCamera
	if camera and (entry.root.Position - camera.CFrame.Position).Magnitude > HEAR_RANGE then return end

	local spur = entry.spurs:FindFirstChild(side .. "Spur")
	local rowel = spur and spur:FindFirstChild("Rowel")
	if not rowel then return end

	local isSprint = info.sprinting
	local speed = info.speed or 0
	local loadFactor = getLoadFactor(entry.character)

	-- Surface EQ
	local material = getFootMaterial(entry.character, side)
	local surf = material and SURFACE_EQ[material] or DEFAULT_SURFACE

	-- Per-spur asymmetry
	local spurAsym = entry.asym[side] or 1

	-- Rowel physics state
	local spin = entry.spin[rowel]
	if not spin then
		spin = { vel = 0, angle = 0, target = 0, lastClick = -100 }
		entry.spin[rowel] = spin
	end

	-- Impulse from step impact
	local impulse = isSprint and ROWEL_IMPULSE_RUN or ROWEL_IMPULSE_WALK
	-- Heavier load = slightly more impulse (more weight on foot)
	impulse *= (1 + loadFactor * 0.15)
	spin.vel += impulse * spurAsym

	-- === SOUND LAYER 1: ROWEL CLICKS (distinct teeth striking) ===
	-- Only emit a click if rowel is slow enough for distinct teeth
	if spin.vel < RATTLE_THRESHOLD then
		local now = os.clock()
		if now - spin.lastClick >= CLICK_MIN_GAP then
			spin.lastClick = now
			local pick = rng:NextInteger(1, 3)
			local s = soundFor(rowel, "Click" .. pick, SOUND_CLICK[pick])
			s.Volume = BASE_VOLUME_CLICK * surf.click * spurAsym * rng:NextNumber(0.9, 1.1)
			s.PlaybackSpeed = surf.pitch * (1 - loadFactor * 0.08) * rng:NextNumber(0.96, 1.04)
			s.TimePosition = 0
			s:Play()
		end
	end

	-- === SOUND LAYER 2: JINGLEBOB CHIMES (dangling weights swinging) ===
	-- Always chime, but tone shifts with load/surface
	local jPick = rng:NextInteger(1, 3)
	local js = soundFor(rowel, "Jingle" .. jPick, SOUND_JINGLE[jPick])
	js.Volume = BASE_VOLUME_JINGLE * surf.jingle * spurAsym * rng:NextNumber(0.85, 1.05)
	js.PlaybackSpeed = surf.pitch * (1 - loadFactor * 0.1) * rng:NextNumber(0.92, 1.08)
	js.TimePosition = 0
	js:Play()

	-- === SOUND LAYER 3: RATTLE (free-spin at speed) ===
	if spin.vel >= RATTLE_THRESHOLD and not spin.rattlePlaying then
		spin.rattlePlaying = true
		local rs = soundFor(rowel, "Rattle", SOUND_RATTLE)
		rs.Volume = BASE_VOLUME_RATTLE * surf.click * spurAsym
		rs.PlaybackSpeed = surf.pitch * 1.15
		rs.Looped = true
		rs.TimePosition = 0
		rs:Play()
		spin.rattleSound = rs
	elseif spin.vel < RATTLE_THRESHOLD * 0.7 and spin.rattlePlaying then
		-- Hysteresis: stop rattle when slowed down enough
		if spin.rattleSound then spin.rattleSound:Stop() end
		spin.rattlePlaying = false
	end

	-- Leather creak on heavy steps (sprint + load)
	if isSprint and loadFactor > 0.5 and rng:NextNumber() < 0.35 then
		local ls = soundFor(rowel, "LeatherCreak", SOUND_CLICK[1])
		-- reuse click asset at very low pitch for creak
		ls.Volume = 0.12 * loadFactor * spurAsym
		ls.PlaybackSpeed = 0.45 * (1 - loadFactor * 0.2)
		ls.TimePosition = 0
		ls:Play()
	end

	-- Visual rowel rotation target
	local weld = rowel:FindFirstChild("RowelWeld")
	if weld then
		local vspin = entry.spin[weld]
		if not vspin then
			vspin = { base = weld.C0, angle = 0, target = 0 }
			entry.spin[weld] = vspin
		end
		-- Each step advances by 1-2 teeth depending on speed
		vspin.target += ROWEL_NOTCH * (isSprint and 2 or 1) * spurAsym
	end
end

local function untrack(character)
	local entry = tracked[character]
	if not entry then return end
	-- Stop any playing rattle sounds
	for _, spin in pairs(entry.spin) do
		if spin.rattleSound then spin.rattleSound:Stop() end
	end
	tracked[character] = nil
	if entry.stop then entry.stop() end
end

local function track(character, spurs)
	untrack(character)
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

	-- Generate per-spur asymmetry
	local leftAsym = asym()
	local rightAsym = asym()

	local entry = {
		character = character,
		spurs = spurs,
		humanoid = humanoid,
		root = root,
		spin = {},
		asym = { LeftSpur = leftAsym, RightSpur = rightAsym }
	}
	tracked[character] = entry

	-- Pre-create sound instances on each rowel
	for _, side in ipairs({ "LeftSpur", "RightSpur" }) do
		local spurModel = spurs:FindFirstChild(side)
		local rowel = spurModel and spurModel:FindFirstChild("Rowel")
		if rowel then
			for i = 1, 3 do
				soundFor(rowel, "Click" .. i, SOUND_CLICK[i])
				soundFor(rowel, "Jingle" .. i, SOUND_JINGLE[i])
			end
			soundFor(rowel, "Rattle", SOUND_RATTLE)
			soundFor(rowel, "LeatherCreak", SOUND_CLICK[1])
		end
	end

	entry.stop = FootPlant.watch(character, function(side, info)
		onStep(entry, side, info)
	end)
end

local function watchCharacter(character)
	local function check(child)
		if child.Name == "DeputySpurs" and child:IsA("Model") then track(character, child) end
	end
	for _, c in ipairs(character:GetChildren()) do check(c) end
	character.ChildAdded:Connect(check)
	character.ChildRemoved:Connect(function(child)
		if child.Name == "DeputySpurs" and tracked[character] and tracked[character].spurs == child then untrack(character) end
	end)
	character.AncestryChanged:Connect(function(_, parent)
		if parent == nil then untrack(character) end
	end)
end

local function watchPlayer(p)
	if p.Character then task.spawn(watchCharacter, p.Character) end
	p.CharacterAdded:Connect(watchCharacter)
end
for _, p in ipairs(Players:GetPlayers()) do watchPlayer(p) end
Players.PlayerAdded:Connect(watchPlayer)

-- Render loop: rowel physics + visual rotation
RunService.Heartbeat:Connect(function(dt)
	for _, entry in pairs(tracked) do
		-- Physics integration for each rowel
		for rowel, spin in pairs(entry.spin) do
			if rowel.Parent == nil then
				entry.spin[rowel] = nil
			else
				-- Drag decay
				spin.vel = math.max(0, spin.vel - ROWEL_DRAG * dt)

				-- Visual rotation easing
				local weld = rowel:FindFirstChild("RowelWeld")
				if weld then
					local vspin = entry.spin[weld]
					if vspin and math.abs(vspin.target - vspin.angle) > 0.002 then
						vspin.angle += (vspin.target - vspin.angle) * math.min(1, dt * 12)
						weld.C0 = vspin.base * CFrame.Angles(vspin.angle, 0, 0)
					end
				end
			end
		end
	end
end)