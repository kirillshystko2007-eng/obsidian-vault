---
tags: [roblox, pandemic-express, report, first-island, station]
date: 2026-10-28
goal: G1
status: done
---
# Отчёт 2026-10-28 — Станция Canyon Crossing (G1, позиция 16)

Журнал: [[PE Отчёты — журнал]]. Цель: [[PE_Goals_10_FirstIsland_Buildings]] → реестр [[PE_Goals_11_Building_Inventory]] (позиция 16). Связано: [[PE_Goals_15_Train_Route]], [[PE 15 - Поезд]].

> [!info] Поправка к реестру
> Реестр G1.1 писал «станции нет — только `Ticket Counter`». **Это неверно:** станция есть — зал с двускатной крышей, навес на резных столбах, часы, вывески CANYON CROSSING STATION, водонапорная башня, сигнал, ступени с четырёх сторон. Обмер её пропустил, потому что всё это — **несгруппированные части в корне Workspace** (часть тех 692 частей).

![[2026-10-28_Station_exterior.jpg]]

## Решение: не перестраивать, а обставить

От этих частей зависят маршрут поезда и поездка: `Wraparound PlatformTrain` (верх Y 28.55 — высота поезда, решение 2026-10-27), `TravelArrival_CanyonCrossing`, промпт `Ticket Counter.TravelPrompt` (TravelTo = Gravesend). Параллельно идёт работа над Поездом 2. Поэтому существующие части **не двигались и не группировались** — всё новое лежит отдельной моделью.

## Что добавлено

Модуль `ServerStorage.CanyonCrossingStation` → `Workspace.CanyonCrossingStationInterior` (121 part, атрибут `BuiltBy`):

- за кассой: ячейки с билетами, сейф, табурет кассира, телеграфный стол (ключ, клопфер), фонарь, «TICKETS — CASH ONLY»;
- над перекрёстком проходов — двусторонняя доска **DEPARTURES / GRAVESEND — RING THE BELL / NO SCHEDULE BY ORDER OF THE BOARD OF HEALTH**;
- объявления на стенах: проверка пассажиров на лихорадку, WANTED банда Calloway (связь с Outlaw's Roost), «NO FIREARMS DRAWN ON THE PLATFORM», потерянный сундук;
- угол с печкой у западной стены: буржуйка с трубой и светом, 2 стула, газета, плевательница, ящик;
- тележка с багажом у восточного выхода (сундук, чемодан, шляпная коробка);
- 4 фонаря над залом.

| До | После |
|---|---|
| ![[2026-10-28_Station_hall_before.jpg]] | ![[2026-10-28_Station_hall_after.jpg]] |

## Проверка

- Свободны (проверка коробками на коллизию против новой модели): проход дверь↔дверь (x -303…-288), проход между боковыми входами (z 4307…4321), площадка прибытия `TravelArrival_CanyonCrossing` (-292, 4318).
- Существующие части станции, промпт и маркер не изменены.
- Скриншоты — при временном дне, ночь возвращена (ClockTime 0.4).

## Откат

Удалить `Workspace.CanyonCrossingStationInterior` (и при желании модуль). Пересборка: `require(game.ServerStorage.CanyonCrossingStation:Clone()).build()`. **Плейс не сохранён** — Ctrl+S в Studio.

## Что дальше

- Сгруппировать части станции в модель — только по решению пользователя и с проверкой ссылок (TravelService, Train2/Train1 код).
- G1: чек-лист G1.2 для позиций 1–5 (Saloon, Church, Sheriff & Jail, Tarot Tent, Gun & Equipment Shop).
