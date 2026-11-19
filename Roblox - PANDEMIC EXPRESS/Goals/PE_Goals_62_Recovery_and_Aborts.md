---
tags: [roblox, pandemic-express, goals, reliability]
status: done
---
# G6.2 — Восстановление и отмена поездки

Родитель: [[PE_Goals_60_Transport_Integration]]. Связано: [[PE_Goals_42_Pickup_Trip_Control]], [[PE_Goals_52_Boarding_Exit]], [[PE_Goals_53_Journey_Operations]], [[PE_Goals_70_Acceptance]].

Поездка затрагивает позиции персонажей, seats, UI, временные рельсы и state машины. Ошибки должны сводиться к безопасной известной точке, а не зависанию игрока или невидимому session.

### Обязательный recovery

- root/humanoid отсутствует в середине перехода;
- персонаж умер/переродился;
- игрок disconnect;
- маршрут остановлен/marker исчез/путь не создан;
- заполнен поезд или игрок нажал prompt повторно;
- не пришёл client ack/GUI не создан;
- TripId устарел, пока поздняя задача завершилась;
- один игрок в группе пропал, остальные продолжают путь.

На каждом переходе определить: владелец server state, idempotent cleanup, назначение safe return CFrame, снятие `Anchored`/disable controls, освобождение seat/room slot, remote уведомление и таймаут. Очистка должна срабатывать и при graceful abort, и при PlayerRemoving. Никакой клиентский timeout не должен единолично записывать прибытие. Связано: `PE 04 - Сетевые контракты`.


**Сделано 2026-11-08:** [[PE Отчёт 2026-11-08 — G6, связка поезда с TravelService и восстановление]].
