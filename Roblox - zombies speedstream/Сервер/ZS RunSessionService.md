---
tags: [roblox, zombies-speedstream, map, server]
snapshot: 2026-11-19
---
# RunSessionService

Карта: [[ZS 08 - Карта плейса]] · кластер **Сервер**

Ядро забега: один Heartbeat-цикл, каждый объект дороги решается один раз по resolveZ; атаки по расписанию с предупреждением; пауза и интро (hold). Баг: пауза вычитается дважды (ZS 07).

| | |
|---|---|
| Путь | `ServerScriptService.Services.RunSessionService` |
| Класс | ModuleScript |
| Строк | 1906 |

## Подключает (require)
- [[ZS BossService]]
- [[ZS BuffService]]
- [[ZS Config]]
- [[ZS CourseBuilder]]
- [[ZS DataService]]
- [[ZS Economy]]
- [[ZS EventService]]
- [[ZS Log]]
- [[ZS MutationService]]
- [[ZS ProgressService]]
- [[ZS RouletteService]]
- [[ZS TransformService]]

## Кто подключает
- [[ZS Main]]
- [[ZS EggService]]
- [[ZS BaseService]]
- [[ZS ShopService]]
- [[ZS WardrobeService]]
- [[ZS FortService]]
- [[ZS RaidService]]

## Ремоуты
- [[ZS ремоут RunRequest]]
- [[ZS ремоут RunEvent]]

Баг: [[ZS 07 - Плейтест 2026-11-19]]
