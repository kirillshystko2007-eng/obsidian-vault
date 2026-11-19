---
tags: [roblox, zombies-speedstream, map, server]
snapshot: 2026-11-19
---
# CompanionService

Карта: [[ZS 08 - Карта плейса]] · кластер **Сервер**

Экипировать / поставить на базу / переставить / отпустить компаньона, покупка апгрейдов.

| | |
|---|---|
| Путь | `ServerScriptService.Services.CompanionService` |
| Класс | ModuleScript |
| Строк | 240 |

## Подключает (require)
- [[ZS BaseService]]
- [[ZS Config]]
- [[ZS DataService]]
- [[ZS Economy]]
- [[ZS Net]]

## Кто подключает
- [[ZS Main]]

## Net-действия (через [[ZS ремоут ShopRequest]])
`Equip`, `Unequip`, `Place`, `MoveSlot`, `Unplace`, `Release`, `BuyUpgrade`
