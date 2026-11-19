---
tags: [roblox, zombies-speedstream, map, server]
snapshot: 2026-11-19
---
# BaseService

Карта: [[ZS 08 - Карта плейса]] · кластер **Сервер**

Участки игроков (6), пьедесталы, пассивный доход в Storage, сбор на площадке; без свободного участка — только warn.

| | |
|---|---|
| Путь | `ServerScriptService.Services.BaseService` |
| Класс | ModuleScript |
| Строк | 723 |

## Подключает (require)
- [[ZS Config]]
- [[ZS DataService]]
- [[ZS Economy]]
- [[ZS Log]]
- [[ZS Monsters]]
- [[ZS Net]]
- [[ZS RunSessionService]]
- [[ZS ZoneBuilder]]

## Кто подключает
- [[ZS Main]]
- [[ZS CompanionService]]
- [[ZS FortService]]
- [[ZS RaidService]]

## Ремоуты
- [[ZS ремоут RunEvent]]

## Net-действия (через [[ZS ремоут ShopRequest]])
`UnlockZone`, `CollectPet`, `Collect`, `GoToBase`

## Локации хаба
- [[ZS локация Plots]]
