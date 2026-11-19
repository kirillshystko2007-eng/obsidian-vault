---
tags: [roblox, pandemic-express, goals, integration, travel]
status: done
---
# G6.1 — Согласовать новый транспорт с TravelService

Родитель: [[PE_Goals_60_Transport_Integration]]. Существующая система: `PE 15 - Поезд`. Зависимости: [[PE_Goals_15_Train_Route]], [[PE_Goals_42_Pickup_Trip_Control]].

Актуальный `TravelService` мгновенно переносит игрока после fade, использует `TravelTo` prompts, tagged arrival markers, `LastStation` и блокирует `InArmory`/`Downed`. Новая маршрутная поездка длится и обслуживает группу. Нужно разделить команды `board train` и `instant travel` либо мигрировать полностью.

### Решение и реализация

- Составить список всех Prompt с атрибутом `TravelTo`, всех `TravelArrival` tags/Station attrs и серверных `TravelTo:Invoke` callers.
- Для каждой станции указать режим: train boarding, quick teleport, либо другое. Убрать двусмысленные кнопки/одновременный handler.
- Решить, продолжает ли `TravelClient` использовать `TravelRemote` как journey card или новая coordinator-система создаёт state-aware экран.
- Сохранить запреты `Downed`/`InArmory`; добавить блокировки по train session/state.
- Обеспечить backwards compatibility старых marker names или сделать одноразовую миграцию по утверждённому списку.

**Готово:** каждый prompt имеет один ясный server path, отсутствует teleport во время занятого trip, а существующие станции работают по выбранным правилам.


**Сделано 2026-11-08:** [[PE Отчёт 2026-11-08 — G6, связка поезда с TravelService и восстановление]].
