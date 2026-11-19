---
tags: [roblox, zombies-speedstream, map, remote]
snapshot: 2026-11-19
---
# ShopRequest

Карта: [[ZS 08 - Карта плейса]] · кластер **Ремоуты**

`ReplicatedStorage.Remotes.ShopRequest` — RemoteFunction, клиент → сервер.

Все действия вне забега через Net (33 действия, ответ { ok, err }).

## Используют
- [[ZS Net]]
- [[ZS ClientState]]
- [[ZS UpgradeMaster]]

## Сервисы с Net-действиями
- [[ZS EggService]]: `BuyEgg`
- [[ZS BaseService]]: `UnlockZone`, `CollectPet`, `Collect`, `GoToBase`
- [[ZS CompanionService]]: `Equip`, `Unequip`, `Place`, `MoveSlot`, `Unplace`, `Release`, `BuyUpgrade`
- [[ZS ShopService]]: `BuyShopItem`, `ClaimDaily`, `SelectMap`, `DebugGrant`, `Leaderboard`
- [[ZS ProgressService]]: `Forms`, `ClaimMission`, `Cosmetic`, `DebugProgress`
- [[ZS WardrobeService]]: `OpenCase`, `EquipWardrobe`
- [[ZS FortService]]: `FortUpgrade`, `FortDefense`
- [[ZS RaidService]]: `RaidTargets`, `RaidGoTo`, `DebugRaid`
- [[ZS MutationService]]: `MutCapsule`, `MutEquip`, `MutUnequip`, `MutUpgrade`, `MutEvolve`

Подробно: [[ZS 01 - Архитектура и сеть]]
