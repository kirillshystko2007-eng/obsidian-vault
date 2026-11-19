---
tags: [roblox, pandemic-express, report, train, integration]
date: 2026-11-08
goals: [G6, G6.1, G6.2]
---
# PE Отчёт 2026-11-08 — G6: связка поезда с TravelService и восстановление

Цели: [[PE_Goals_60_Transport_Integration|G6]], [[PE_Goals_61_Travel_Service_Integration|G6.1]], [[PE_Goals_62_Recovery_and_Aborts|G6.2]]. Продолжение: [[PE Отчёт 2026-11-08 — Поезда 1 и 2, рейс по расписанию]].

## G6.1 — у каждого prompt один серверный путь

Инвентаризация (live DataModel, Edit):

| Объект | Путь | Режим |
|---|---|---|
| Prompt | `Workspace.CanyonCrossingStation.Ticket Counter.TravelPrompt` (TravelTo=Gravesend, TrainStation=CanyonCrossing) | поезд (`TrainService.book`); при `TrainState.Enabled=false` — мгновенная поездка `TravelService` |
| Prompt | `…Locations.Gravesend Depot.DepartureBell.TravelPrompt` (TravelTo=CanyonCrossing, TrainStation=Gravesend) | то же |
| TravelArrival | `Workspace.CanyonCrossingStation.TravelArrival_CanyonCrossing` (Station=CanyonCrossing) | точка высадки обоих путей |
| TravelArrival | `…Gravesend Depot.TravelArrival` (Station=Gravesend) | то же |
| DepartureBoard | обе станции | табло `TrainService` |
| `ServerStorage.TravelTo:Invoke` | вызывающих скриптов нет | оставлен как rescue API |

Правило выбора одно на оба сервиса: `TrainState.Enabled` → prompt обрабатывает только `TrainService`; иначе только `TravelService`. Других телепортов игроков, кроме Armory, нет (`R6Spawn` двигает только при спавне).

**Новое — общий замок перемещения** `ServerStorage.TeleportUtil`: `U.claim(player, owner)` / `U.free` / `U.holder`, атрибут игрока `TeleportBusy` = `train` | `travel` | `armory`. Пока замок у одной системы, остальные отказывают, а не телепортируют одновременно.
- `TravelService`: `refusal()` — отказ для `OnTrain`, `InArmory`, `Downed`, мёртвых и занятых; `TravelTo:Invoke` теперь возвращает `true` только если поездка реально началась, иначе `false, причина` (раньше — `true` для любой известной станции).
- `TrainService.book/putOff` держат замок `train`.
- `ArmoryService.enter/leave` держат замок `armory` и не пускают пассажиров (`OnTrain`).

## G6.2 — восстановление

| Сбой | Что теперь |
|---|---|
| ошибка Lua посреди посадки / высадки / мгновенной поездки | тело в `pcall`; всегда снимаются `moving`, замок, `Anchored`, шлётся `arrive` (экран не остаётся чёрным) |
| abort / остановка, пока посадка уже перенесла игрока в вагон | `book` видит устаревший TripId → игрок в интерьере → `putOff` обратно на платформу («boarding cancelled») |
| пропал TravelArrival станции | `dropTarget()`: пересканировать станции → маркер другой станции (warn) → SpawnLocation → платформа CC. Раньше sweeper бесконечно повторял неудачный `putOff` каждые 2 с |
| `TrainState.Enabled` выключили во время рейса | все пассажиры высажены (до середины пути — туда, где садились, после — в пункт назначения), брони отменены с сообщением, посторонние в вагонах высажены, `Phase=Suspended`, табло «TIMETABLE SUSPENDED», prompt «Travel to …», внешний поезд стоит на станции (Epoch +1e7 → Halted) |
| `Enabled` включили обратно | расписание заново: посадка в Canyon Crossing через 15 с; без Train2Scene/мест включение откатывается с warn |
| abort в фазе Halted | станция = `From` (там стоит поезд); раньше бралось `To` |
| не пришёл `arrive` на клиенте | `TravelClient` watchdog: через объявленное время поездки + 15 с снимает чёрную карточку. Только экран — позицию решает сервер |
| смерть, респавн, выход, повторное нажатие, полный поезд, устаревший TripId, пропал один игрок из группы | уже было в G4 (`diedConn`, `CharacterAdded`, `PlayerRemoving`, `moving`, резерв на следующий поезд, `tripId`, высадка поштучно) — проверено заново |

## Проверка в Play (Studio, звук выключен)

Через `ServerStorage.TrainDebug` и `TravelTo:Invoke` (prompts из MCP не нажимаются):
- посадка → `OnTrain=true`, `TeleportBusy=nil`, `Anchored=false`; `TravelTo` пассажира → `false/on train`;
- выход во время посадки → платформа CC (-280, 31.5, 4315);
- `TravelTo(Gravesend)` → `TeleportBusy=travel`; `book` в это время → `false/busy`; второй `TravelTo` → `false/moving`; через 7.5 с игрок у Gravesend Depot, замок снят;
- `Enabled=false` на 5-й секунде рейса → пассажир на платформе CC, `Phase=Suspended`, prompt «Travel to Gravesend», табло «TIMETABLE SUSPENDED», `book` → `disabled`, клиент: карточка снята, поезд Halted со скоростью 0;
- `Enabled=true` → посадка через 15 с; бронь + `Enabled=false` → бронь снята;
- маркер Gravesend убран в ServerStorage → высадка с warn «using CanyonCrossing» на платформу CC;
- abort через 1.1 с после начала посадки (игрок уже в вагоне) → платформа, замок снят, не заякорен;
- watchdog: `depart` без `arrive` → через 10 с ещё чёрный, через 19 с снят.

В консоли ошибок нет. Обнаруженная по ходу ошибка с Halted исправлена и перепроверена при повторном запуске.

Скриншотов нет: работа — серверная логика, видимых изменений только табло «TIMETABLE SUSPENDED» в режиме отката. Доказательство — журнал проверок выше.

Заметка про тесты: `execute_luau` получает собственную копию ModuleScript (`require` в контексте плагина ≠ сервер), поэтому `U.claim` из тестового кода не видно сервисам — замок проверять только через настоящие сервисы.

## Backup / откат

`ServerStorage._AnimBackup.<имя>_pre_g6_2026-11-08` для `TravelService`, `TrainService`, `TeleportUtil`, `ArmoryService`, `TravelClient` (скрипты-копии отключены). Откат — вернуть Source из копий.

## Дальше

- [[PE_Goals_70_Acceptance|G7]]: приёмка с 2+ игроками (Studio «Local Server», 2 клиента) — групповая высадка, места, замок при одновременных нажатиях.
- Открыто: на сайте выставить Max Players = 24.
