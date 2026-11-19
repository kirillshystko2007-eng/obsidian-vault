---
tags: [roblox, pandemic-express, goals, train-2, state-machine]
status: done
---
# G4.3 — Режимы ожидания и поездки в Поезде 2

Родитель: [[PE_Goals_50_Train2_Interior]]. Общий flow: [[PE_Goals_15_Train_Route]], [[PE_Goals_60_Transport_Integration]].

Интерьер должен не только отображать вагон, но быть синхронизированной сессией группы пассажиров. Сначала определить одну Trip session с TripId и server-owned state; HUD/клиент — только отображает state.

## Предлагаемые состояния

```text
Idle → Arriving → Boarding → DoorsClosing → Departing → InTransit
     → ArrivingDestination → Disembarking → Returning/Complete
                    ↘ Aborted / Recovery
```

Для каждой фазы определить trigger, допустимые команды, timeout, изменяемые атрибуты и восстановление. Train1 двигается по route в тех же фазах; Train2 показывает cabin и удерживает/обслуживает пассажиров. Ожидание означает видимое время/место/пункт назначения и разрешённое размещение пассажиров, не бесконечный stuck state.

## Обязательные переходы при исключении

- Игрок уходит/умирает: освободить место, оставить trip целой для остальных.
- Рейс отменён/поезд застрял: прекратить boarding, сообщить пассажирам, вернуть их к безопасной платформе.
- Серверный task старого рейса проснулся позже: TripId generation не даёт ему испортить новый рейс.
- Игрок respawned: удалить старое seat binding, не телепортировать новый персонаж устаревшим callback.
- Поезд достиг destination: атомарно открыть выход, разместить пассажиров, записать `LastStation`/направление и подготовить обратный маршрут.

Приёмка полного цикла — [[PE_Goals_70_Acceptance]].
