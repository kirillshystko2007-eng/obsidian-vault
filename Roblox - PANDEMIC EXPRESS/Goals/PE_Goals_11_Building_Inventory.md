---
tags: [roblox, pandemic-express, goals, inventory]
status: in-progress
---
# G1.1 — Реестр зданий первой локации

Родитель: [[PE_Goals_10_FirstIsland_Buildings]]. Данные: [[PE_Goals_01_Baseline_Design]], `PE 21 - Структура карты`.

Создать инвентарь зданий до редизайна. Для каждой записи фиксировать: имя в игре, полный `Workspace` path, локацию/улицу, основной силуэт/материал, игровой функционал, доступные помещения, критичные проходы/интерактивы, текущие проблемы, целевой апгрейд, оценку сложности, статус и ссылку на скрин.

## Как определить полноту

- Найти групповые Models/Folders в подтверждённой границе первой локации.
- Отдельно посмотреть здания, собранные из частей в корне Workspace, и вложенные наборы вроде WesternCity/Saloon.
- Отделить полноценные здания от декора, руин, фасадных оболочек, отдельных домов и тестовых моделей.
- Проверить каждую улицу/площадь/переулок по камерному обходу, чтобы не пропустить не сгруппированный объект.
- Зафиксировать исключения: временные/служебные модели, удаление/сохранение которых требует решения.

## Готово, когда

Реестр покрывает каждое здание в согласованной границе; у каждой позиции есть уникальный стабильный instance path и назначенный статус. Список пустых/сомнительных позиций отправляется на подтверждение, не превращается молча в пропуск.

## Реестр — первая версия (2026-10-27, автоматический обмер)

Граница: остров A, zone `CANYON CROSSING` (центр (-5, 4661), 800×800). Статус всех: **не начато**. Скриншоты не сняты — в Edit mode стоит ночное освещение (ClockTime 0.4), снимки получаются чёрными; для фото нужно временно включить день и потом вернуть.

Метрики: parts — число BasePart; L — источники света; D/W — части с «door» / «window|glass|pane» в имени (грубая эвристика); всё anchored.

| # | Здание | Workspace path | Центр (X,Z) | Размер | parts | L | D/W | Структура / заметки |
|---|---|---|---|---|---:|---:|---|---|
| 1 | Saloon | `Saloon` (`Rebuild` + `Upgrade_Interior`) | (-5, 4551) | 160×56×82 | 3283 | 19 | 27/161 | Уже переделан: Hall, Bar/BackBar, Stage, Balcony, люстры, 72 сиденья. Кандидат в **эталон** (G1.2) |
| 2 | Church | `WesternCity.SouthRow.Church` | (61, 4798) | 49×79×108 | 2447 | 41 | 14/314 | Детальный: Nave, Apse, Tower, Buttresses, Graveyard, интерьер. 912 Metal-частей — проверить оптимизацию |
| 3 | Sheriff & Jail | `WesternCity.NorthRow.SheriffJail` | (-123, 4565) | 72×28×74 | 1330 | 21 | 58/24 | OfficeUpgrade, JailWing, JailYard, FacadeUpgrade — уже прокачан |
| 4 | Cultist Tarot Tent | `WesternCity.NorthRow.CultistTarotTent` | (277, 4559) | 31×41×50 | 627 | 24 | 3/0 | Interior/Shell/Exterior/Decor; 82 Neon |
| 5 | Gun & Equipment Shop | `WesternCity.NorthRow.GunAndEquipmentShop` | (-147, 4532) | 38×30×47 | 571 | 8 | 8/34 | `ShopInterior`; рядом ArmoryOwner и витрины револьверов (магазин) |
| 6 | Mercantile | `WesternCity.NorthRow.Mercantile` | (105, 4571) | 42×30×45 | 405 | 4 | 8/17 | плоская структура (нет подгрупп) |
| 7 | Boarding House | `WesternCity.SouthRow.BoardingHouse` | (110, 4771) | 46×30×45 | 379 | 4 | 8/17 | плоская; похож по массе на Mercantile/Hotel |
| 8 | Grand Hotel | `WesternCity.NorthRow.GrandHotel` | (154, 4572) | 46×30×47 | 365 | 4 | 8/17 | плоская; тот же шаблон, что 6–7 |
| 9 | Livery | `WesternCity.SouthRow.Livery` | (-92, 4771) | 51×23×47 | 233 | 3 | 5/8 | одноэтажный шаблон |
| 10 | Doctor | `WesternCity.SouthRow.Doctor` | (18, 4770) | 35×20×44 | 222 | 3 | 5/8 | одноэтажный шаблон |
| 11 | Telegraph | `WesternCity.NorthRow.Telegraph` | (-133, 4769) | 32×20×44 | 206 | 3 | 5/9 | в NorthRow, но стоит на южной стороне (Z 4769) |
| 12 | Blacksmith | `WesternCity.SouthRow.Blacksmith` | (-50, 4770) | 32×21×43 | 191 | 4 | 5/8 | одноэтажный шаблон |
| 13 | Undertaker | `WesternCity.SouthRow.Undertaker` | (145, 4769) | 29×20×42 | 166 | 3 | 5/6 | одноэтажный шаблон |
| 14 | Gunsmith | `WesternCity.SouthRow.Gunsmith` | (-18, 4769) | 31×20×41 | 163 | 3 | 5/7 | одноэтажный шаблон; самое простое здание |
| 15 | Cowboy Market | `CowboyMarket` | (49, 4931) | 328×20×147 | 511 | 0 | 0/0 | рынок-прилавки, без света |
| 16 | Station / Ticket Counter | `Ticket Counter` (Part) + `TravelArrival_CanyonCrossing` | (-317, 4301) | — | 1 | — | — | **Нет здания станции** — только стойка. Нужна станция для поезда (G5/G6) |

### Не здания, но в границе (решить: входят ли в G1)

`RetroWesternSetpieces.OldWindmill` (-371, 4414), `WesternProps.Windmill` (334, 4549), `WesternProps.Watchtower`, `WesternProps.Wagon`, `WesternProps.Graveyard`, `WesternCity.StreetProps` (MainStreetNorth/South, 12 фонарей, GapDeck/GapStep), `DesertDecor` (≈285 кактусов, 54 камня, дюны, оазис). В корне Workspace лежит **692 несгруппированные части** — разобрать по владельцам.

### Выводы для G1

- Уже прокачаны (1–4): Saloon, Church, SheriffJail, Tarot Tent. Их довести по чек-листу, не перестраивать.
- **Приоритет на апгрейд** — 5 «плоских» шаблонных домов (9–14) и тройка 6–8: одинаковая масса, 3–4 светильника, без подгрупп и интерьерных зон.
- Станции нет — это общая задача G1 и G5/G6.

## Обновление 2026-10-28 — южный ряд перестроен

Позиции **9–14** (Livery, Doctor, Telegraph, Blacksmith, Undertaker, Gunsmith) → статус **готово (1-й проход)**: перестроены модулем `ServerStorage.CanyonCrossingSouthRow` на тех же местах — фальшфасады, вывески, тематические интерьеры, дворы, все двери проходимы. Старые модели: `ServerStorage._MapBackup["SouthRow_pre_rebuild_2026-10-28"]`. Отчёт со скриншотами: [[PE Отчёт 2026-10-28 — Южный ряд Canyon Crossing]].

Следующие: 6–8 (Mercantile, Boarding House, Grand Hotel — 2 этажа, нужна лестница), 16 (станции нет).

Позиции **6–8** (Mercantile, Grand Hotel, Boarding House) → **готово (1-й проход)** тем же модулем: лестница + проём, балкон-галерея, интерьеры обоих этажей. Отчёт: [[PE Отчёт 2026-10-28 — Двухэтажные дома Canyon Crossing]]. Осталась позиция 16 (станция) и чек-лист для 1–5.

Позиция **16** — поправка: станция **есть** (зал, навес, часы, вывески, водонапорная башня — несгруппированные части в корне Workspace вокруг `Wraparound PlatformTrain`). Части не трогались (от них зависят поезд и TravelService); зал ожидания обставлен моделью `Workspace.CanyonCrossingStationInterior`. Отчёт: [[PE Отчёт 2026-10-28 — Станция Canyon Crossing]].
