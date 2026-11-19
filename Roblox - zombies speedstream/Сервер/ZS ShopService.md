---
tags: [roblox, zombies-speedstream, map, server]
snapshot: 2026-11-19
---
# ShopService

Карта: [[ZS 08 - Карта плейса]] · кластер **Сервер**

Магазин за гемы, ежедневный подарок, выбор карты (остаток старой версии), лидерборд сервера.

| | |
|---|---|
| Путь | `ServerScriptService.Services.ShopService` |
| Класс | ModuleScript |
| Строк | 124 |

## Подключает (require)
- [[ZS Config]]
- [[ZS DataService]]
- [[ZS Economy]]
- [[ZS Log]]
- [[ZS Net]]
- [[ZS RunSessionService]]

## Кто подключает
- [[ZS Main]]

## Net-действия (через [[ZS ремоут ShopRequest]])
`BuyShopItem`, `ClaimDaily`, `SelectMap`, `DebugGrant`, `Leaderboard`
