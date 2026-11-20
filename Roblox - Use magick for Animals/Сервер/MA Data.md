---
tags: [roblox, use-magick-for-animals, map, server]
snapshot: 2026-11-19
---
# Data

Карта: [[MA 01 - Карта плейса]] · кластер **Сервер**

Профили игроков: DataStore AlchemyProfiles_v1 с session lock (_lock job/t, TTL 300 с, автосейв раз в 2 мин, BindToClose), репликация профиля клиенту (Sync), уведомления (Notify), единственная точка изменения монет/мастерства/ингредиентов/баффов. Держит таблицу Data.Actions — общий вход Action с лимитом частоты.

| | |
|---|---|
| Путь | `ServerScriptService.Services.Data` |
| Класс | ModuleScript |
| Строк | 353 |

## Подключает (require)
- [[MA Config]]
- [[MA Biomes]]
- [[MA Stats]]
- [[MA Sanctum (общий)]]

## Кто подключает
- [[MA Main]]
- [[MA Nodes]]
- [[MA Pets]]
- [[MA Brewing]]
- [[MA Combat]]
- [[MA World]]
- [[MA Shop]]
- [[MA Magic]]
- [[MA Altars]]
- [[MA Sanctum (сервер)]]

## Ремоуты
- [[MA ремоут Sync]]
- [[MA ремоут Notify]]
- [[MA ремоут FX]]
- [[MA ремоут Action]]

## Места в мире
- [[MA локация Алтари хаба]]

<!-- staffs:start -->
## Посохи (2026-11-20)
- [[MA Staffs (сервис)]] (профиль `staffs`), [[MA Staffs]]
<!-- staffs:end -->
