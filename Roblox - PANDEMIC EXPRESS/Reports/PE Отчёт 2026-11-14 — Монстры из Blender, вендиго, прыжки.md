# PE Отчёт 2026-11-14 — Монстры из Blender, вендиго, прыжки

Связано: [[PE 31 - Монстры]] · [[PE Отчёт 2026-11-13 — Песчаная буря по краю острова]] · [[PE_Goals_00_Roadmap]]

## Что сделано
Запросы пользователя (13–14.11): переделать монстров — сгенерированные модели, анимированные в **Blender** (скелетный риг); вампир — **R6**; чупакабра — страшная, «с изуродованной собачьей мордой»; оборотень — «более звериный», затем «совместить гуманоидную и звериную»; новый босс **вендиго** — тощий, переделан в Blender; прыжки игрока ниже/медленнее, каждый следующий слабее, кулдаун 0.5 с.

### Конвейер (Documents\PandemicExpress_Monsters)
1. Меш из Roblox (generate_mesh) → Studio шлёт OBJ (EditableMesh) и RGBA-текстуру на `127.0.0.1:8765` (`tools\recv.mjs`, разрешено в Assistant HTTP allowlist).
2. Blender 5.3 (`monsters.blend`, управляется через сокет аддона blender-mcp `tools\bl.mjs`): скелет по осевым линиям частей (`b_rig_*.py`), веса — свои, по расстоянию до костей внутри региона (`b_rig_lib.py`), клипы — ключи в осях арматуры (`b_anim_*.py`, `b_anim_lib.py`).
3. `b_bake.py` → `out\<rig>.fbx` (загрузка Open Cloud как Model) + `out\<rig>_anims.json`.
4. Studio: `ServerStorage.MonsterRigAnims` (подгонка костей Blender к импортированным Bone методом Horn, ошибка 0; Bone.Transform = C·basis·C⁻¹) → KeyframeSequence в `ReplicatedStorage.Animations`; `ServerStorage.MonsterRigBuilder` (`build(kind)`, `refreshClips(kind)`, `beast("Skinwalker")`) собирает шаблон: HRP + Humanoid (R15, HipHeight) + меш на Motor6D `BodyRoot` + невидимая `Head` на кости головы (RigidConstraint, HitZones) + HitBox + мозг/атрибуты старого шаблона.
5. `ServerScriptService.SkinnedMonsterAnimator` — idle/шаг/бег/вздрагивание/пошатывание/смерть для скелетных (NPCAnimator работает только с R6); `DeathAnimations` понимает атрибуты `DeathAnimation`, `RootHeight`.

### Монстры
| Монстр | Модель | Клипы |
|---|---|---|
| Оборотень (`WerewolfTemplate.Werewolf`) | риг 105108629598036 | WolfIdle/Walk (стоя), WolfRun — галоп на 4 лапах, WolfStalk, Swipe (выпад), Howl, Pounce, Hit, Stagger, Death. Мозг: бродит стоя (7), охотится на четырёх (полная скорость) |
| Чупакабра (`MonsterTemplates.Chupacabra`) | ChupacabraMesh5, риг 100997183141526 | Idle, Walk, Run, Bite, Hit, Stagger, Death |
| Скинуокер | R6-путник + скрытый скелетный зверь (риг 107587017625267), при раскрытии путник исчезает, зверь появляется, голова-хит переходит к черепу | SkinTransform, Idle, Walk, Run, Slash, Hit, Stagger, Death |
| Вампир | R6, части меша (78962860487243) на конечностях (`MonsterMeshRig`, параметр `turn`) | старые R6-клипы |
| **Вендиго (босс)** `MonsterTemplates.Wendigo` | WendigoMesh2, ремодель «тощий» в Blender (`b_wend_thin.py`: вершины к осям костей) | WendIdle, Walk, Run, Claw, Slam, Scream, Bite, Hit, Stagger, Death |

**Вендиго** (MonsterCore `Wendigo`): 13 стадов, 3000 HP, награда 600, BossName «The Wendigo»; визг при первом взгляде и каждые ~18 с в ярости (<50 %) — урон 10 всем в 40 стадах, лечится; рывок на 24 при дистанции >22; удар когтями (30), удар о землю (×1.35 по площади 13 стадов, пыль), укус по раненой цели (лечит 120). Спавн: `MonsterSpawner` — ночью, один на острове, Bloodwood Mill / Blackwater Bayou, респаун 15 мин.

### Прыжки (`R6Spawn`)
Высота 4.6 (было 7.2), кулдаун 0.5 с (было 5), подряд (в пределах 1.6 с): 100/70/50/35 %; атрибут игрока `JumpChain`.

## Проверка в Play
- Оборотень/чупакабра: стоят на земле, idle → бег переключается, смерть — свой клип + тело на RootHeight.
- Скинуокер раскрылся вблизи: зверь виден, путник скрыт, SkinDeath назначен; бой шёл без ошибок (пользователь стрелял по монстрам в той же сессии).
- Вендиго: визг (−10 HP игроку), рывок, удар о землю, шаг; стоит на земле.
- Прыжки: 4.69 / 3.29 / 2.36 подряд, после отдыха снова 4.6.
- Лог: 0 ошибок новых скриптов.
- Не проверено: двое игроков, долгий бой с вендиго до смерти, спавн вендиго по расписанию ночью.

## Откат
`_MapBackup.<Имя>Template_R6_pre_bonerig_2026-11-13`, `VampireTemplate_R6_pre_meshpieces_2026-11-13`, `WerewolfTemplate_pre_meshremodel_2026-11-13`; `_AnimBackup.MonsterClips_R6_pre_bonerig_2026-11-13` (старые клипы), `DeathAnimations_/MonsterCore_pre_bonerig_2026-11-13`, `WerewolfBrain_pre_combinedgait_2026-11-13`, `R6Spawn_pre_jumpchain_2026-11-13`. Заготовки моделей: `_MapBackup.MonsterMeshes_2026-11-13`.
