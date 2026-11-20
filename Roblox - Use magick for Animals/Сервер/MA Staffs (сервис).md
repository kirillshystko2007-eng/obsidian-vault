---
tags: [roblox, use-magick-for-animals, map, server, staffs]
snapshot: 2026-11-20
---
# Staffs (сервис)

Карта: [[MA 01 - Карта плейса]] · кластер **Сервер** · система [[MA 03 - Посохи]]

Серверная часть посохов: модель посоха на руке/спине, мини-питомец в шаре, болты и способности (урон по расписанию под эффекты), опыт посоха и питомца за убийства, покупка/экипировка/запечатывание. В Studio — отладочный `ServerStorage._StaffDebug`.

| | |
|---|---|
| Путь | `ServerScriptService.Services.Staffs` |
| Класс | ModuleScript |
| Строк | 557 |

## Подключает (require)
- [[MA Staffs]]
- [[MA Biomes]]
- [[MA Creatures]]
- [[MA PetModels]]
- [[MA Config]]
- [[MA Data]]
- [[MA Pets]]
- [[MA Combat]]
- [[MA Sanctum (общий)]]

## Кто подключает
- [[MA Main]]
- [[MA Data]]
- [[MA Pets]]
- [[MA Combat]]
- [[MA Sanctum (сервер)]]

## Ремоуты
- [[MA ремоут Action]]
- [[MA ремоут FX]]

## Обрабатывает действия Action
`StaffBolt`, `StaffAbility`, `StaffAim`, `StaffDraw`, `StaffBuy`, `StaffEquip`, `StaffSocket`, `StaffUnsocket`
