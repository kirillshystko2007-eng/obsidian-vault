---
tags: [roblox, use-magick-for-animals, map, remote]
snapshot: 2026-11-19
---
# Action

Карта: [[MA 01 - Карта плейса]] · кластер **Ремоуты**

`ReplicatedStorage.Remotes.Action` — RemoteFunction, клиент → сервер.

Единый вход для действий игрока: Data.Actions[name], лимит 0.03 с на всё и 0.12 с на одно действие, pcall вокруг обработчика.

## Используют
- [[MA Data]]
- [[MA Pets]]
- [[MA World]]
- [[MA Shop]]
- [[MA Magic]]
- [[MA Altars]]
- [[MA Sanctum (сервер)]]
- [[MA UI]]
- [[MA Panels]]
- [[MA MagicPanels]]
- [[MA Hotbar]]
- [[MA Altar]]
- [[MA Sanctum (клиент)]]
- [[MA BroomFlight]]

## Обработчики (Data.Actions)
- [[MA Pets]]: `Equip`, `Unequip`, `EquipBest`, `Release`
- [[MA World]]: `Teleport`
- [[MA Shop]]: `BuyUpgrade`, `BuyPotion`, `UsePotion`, `ClaimDaily`, `ClaimQuest`, `ClaimSet`
- [[MA Magic]]: `Rebirth`, `BuyBroom`, `EquipBroom`, `UpgradeBroom`, `Mount`, `Dismount`
- [[MA Altars]]: `AltarBegin`, `AltarFinish`
- [[MA Sanctum (сервер)]]: `SanctumPlace`, `SanctumRemove`, `SanctumCollect`, `SanctumUpgrade`, `SanctumHome`

<!-- staffs:start -->
## Посохи (2026-11-20)
- [[MA Staffs (сервис)]] — StaffBolt, StaffAbility, StaffAim, StaffDraw, StaffBuy, StaffEquip, StaffSocket, StaffUnsocket
<!-- staffs:end -->
