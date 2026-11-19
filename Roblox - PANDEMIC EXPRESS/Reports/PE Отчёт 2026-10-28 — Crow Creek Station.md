---
tags: [roblox, pandemic-express, report, second-island, location]
date: 2026-10-28
goal: G2.1
status: done
---
# Отчёт 2026-10-28 — Crow Creek Station

Журнал: [[PE Отчёты — журнал]]. Цель: [[PE_Goals_21_Island_Masterplan]] (G2.1) → [[PE_Goals_20_SecondIsland_Plan]]. Связано: [[PE 22 - География зон]], [[PE 16 - Discovery]], [[PE 17 - Деньги]], [[PE 21 - Структура карты]].

> [!success] Итог
> Закрыт последний пустой участок острова B из мастер-плана (полоса X -140…-20, Z -1920…-2300). Построена локация **Crow Creek Station** — станция дилижансов у ручья, и **сквозная почтовая дорога** Gravesend ↔ Outlaw's Roost. Проверено в Play: зона, discovery (+$25), 8 точек лута. Без NPC и ZombieSpawn (решение пользователя 2026-10-27).

![[2026-10-28_CrowCreek_aerial.jpg]]

## Что построено

Модуль `ServerStorage.FrontierLocations.CrowCreekStation` → модель `DeadFrontierMap.CompleteWorld.Locations["Crow Creek Station"]`, центр (-80, -2110), **1319 parts, 18 источников света**. Зона `CROW CREEK STATION` — «The last coach came back on its side.» (140×300, priority 1).

| Объект | Локальная позиция | Что внутри |
|---|---|---|
| Station House | (-34, 12), фасадом к дороге | 2 этажа, балкон, крыльцо, вывеска CROW CREEK STATION; контора (office) + телеграфный стол с ключом, клопфером и неотправленной телеграммой «TO GRAVESEND / SEND THE DOC / THEY ARE GETTING» |
| Home Station | (-32, -30) | столовая для пассажиров (bar), фальшфасад «MEALS 25c» |
| Drivers' Cabin | (-36, 50) | бревенчатый дом кучеров (house), колодец, уборная |
| Stables | (24, 62), фасадом к дороге | красный амбар STAGE LINE STABLES: 4 стойла с сеном, кормушками и упряжью, сеновал на балках, лестница-truss |
| Smithy | (20, -24) | открытый навес: кузнечный горн с огнём, мехи, наковальня, бочка, подковы, запасное колесо |
| Corral | (10…38, -66…-96) | загон, поилка, сено |
| Stagecoach | у крыльца станции | целый дилижанс «OVERLAND MAIL» (кузов, колёса с ободами, козлы, багажник, ремни-рессоры, сундуки на крыше) |
| LastCoach | на дороге к югу | перевёрнутый дилижанс, отлетевшее колесо, сундуки, письма, череп |
| Notice | перед станцией | «NOTICE — THIS LINE IS CLOSED BY ORDER OF THE BOARD OF HEALTH» (связь с сюжетом эпидемии) |
| Телеграф | восточная обочина | 12 столбов с изоляторами и проводами по всей длине |
| Passengers' graveyard | (-38, 110) | ограда, 7 крестов с именами (J. HOLLIS — DRIVER, SHOTGUN MESSENGER, A CHILD…), мёртвое дерево, табличка PASSENGERS |
| Water tower, windmill | (14, 104), (-50, -62) | силуэты, видимые с дороги; ветряк крутится (WA_Spin) |
| Footbridge | через Crow Creek, z -45 | пролёт ищет реальные берега ручья, горбик, перила, сваи, фонарь |
| Знаки, фонари | вдоль дороги | «GRAVESEND 2 MI», «STILLWATER LANDING», 6 фонарных столбов |

### Дорога
Почтовый тракт по оси локации: на юг — к западному концу Main Street Gravesend (-78, -2545), на север — мимо озера к подножию тропы Outlaw's Roost (46, -1890). Теперь у острова есть прямой маршрут север–юг через центр (см. критерий «минимум два перехода» в [[PE_Goals_21_Island_Masterplan]]).

## Доказательства

| | |
|---|---|
| ![[2026-10-28_CrowCreek_station.jpg]] | ![[2026-10-28_CrowCreek_lastcoach.jpg]] |
| Станция, столовая, дилижанс, объявление, телеграф | Перевёрнутый дилижанс на тракте, колесо и сундуки |
| ![[2026-10-28_CrowCreek_bridge.jpg]] | ![[2026-10-28_CrowCreek_stables.jpg]] |
| Мост через Crow Creek; на фоне кузня, амбар, станция | Стойла внутри амбара |
| ![[2026-10-28_CrowCreek_graveyard.jpg]] | |
| Кладбище пассажиров | |

Скриншоты сняты в Edit с временно включённым днём (ClockTime 14.5); исходное освещение сохранено в `ServerStorage._InspectLightingSave`, затем **восстановлено** (ClockTime 0.4, Brightness 2.2, FogEnd 900, Exposure 0.3) и сохранение удалено.

### Проверка в Play (2026-10-28)
- `LootSpawn` с `Location = Crow Creek Station`: **8**, на старте заполнено 6 (Lockbox с промптом «Search») — соответствует `START_ACTIVE 0.7`.
- Игрок перемещён в центр (`HumanoidRootPart`, не PivotTo): клиент `CurrentZone = CROW CREEK STATION`, HUD показывает название.
- DiscoveryService: `DiscoverTotal = 17` (все зоны с Subtitle), Discovered 1 → 3, **Cash 275 → 325** (+25 THE DEAD FRONTIER, +25 CROW CREEK STATION).
- Консоль: только ожидаемые ошибки DataStore (в Studio выключен доступ к API). `SunAnimatorStudio` при запуске **не появился** — плагин, похоже, удалён.

## Лут
8 точек Tier 2 (как Quarantine/Widow's Mine): стол телеграфиста, у лестницы станции, за стойкой столовой, на койке кучеров, 2 стойла, у горна, у перевёрнутого дилижанса. Всего на острове теперь **95** точек. Точки лежат в `DeadFrontierMap.LootSpawns` (не в модели), атрибуты `Tier`, `Location`, `Surface`, `Generated=true`, тег `LootSpawn`.

## Технические выводы (важно для следующих локаций)

> [!warning] Terrain: три ловушки, найденные при сборке
> 1. **Пады ложатся выше заданной высоты.** Воксели 4 st: `FillBlock` до Y=33 рисует поверхность на ~34. Если ставить объекты на уровень заливки — всё утоплено на 1–2 st. Решение: пады заливаются до `GY-1`, билдер стоит на `GY` (замерено: 1520 из 1986 проб = 34.0).
> 2. **Покраска `FillCylinder` поднимает землю.** Каждый мазок тропы округляется на воксель вверх → тропа превращается в насыпь, вещи «тонут». Решение: тропы и пятна травы — только `Terrain:ReplaceMaterial` (меняет материал, не высоту). *Старые модули красят старым способом: `b:Paint` (= `FillCylinder` в FrontierKit) есть в 12 из 14 остальных модулей, отдельные `FillCylinder`-тропы — в OutlawsRoost, StillwaterLanding, BlackthornEstate, BloodwoodMill. На скриншоте Roost видны гребни-насыпи вдоль троп; кандидат на доработку (проще всего — сделать `K:Paint` через `ReplaceMaterial` и пересобрать).*
> 3. **Raycast по terrain видит прошлый кадр.** Сразу после `PasteRegion`/`FillBlock` луч возвращает старую высоту → дилижанс висел на 7 st в воздухе. Решение: `task.wait()` после изменений terrain перед `groundY()`; в модуле стоит после падов.

- Всё, что стоит вне падов (столбы, фонари, знаки, кресты, водокачка, мост), берёт высоту через `ly()` (raycast по реальной земле).
- Мост ищет воду на своей линии и начинается/заканчивается в 4 st от уреза, доски наклонены по профилю.

## Откат / пересборка
- Terrain до постройки: `ServerStorage._MapBackup.Terrain_CrowCreek_pre_build_2026-10-28` (TerrainRegion, угол в клетках (-40,0,-640)): `workspace.Terrain:PasteRegion(tr, Vector3int16.new(-40,0,-640), true)`.
- Пересборка: восстановить terrain → `task.wait()` → `require(game.ServerStorage.FrontierLocations.CrowCreekStation:Clone()).build()` → заново расставить лут (точки стабильны: сборка детерминирована seed 7331).
- Деревья и чужие объекты не задеты (проверка пересечений — пусто).

## Что дальше
- [[PE_Goals_22_Location_Brief]] — карточки локаций острова B ещё не написаны (G2.2).
- Перевести `FrontierKit.Paint` и тропы старых локаций на `ReplaceMaterial` и пересобрать (убрать насыпи; сначала backup terrain).
- Когда пользователь разрешит NPC: `ZombieSpawn` части с атрибутом `Location` (на станции место есть в амбаре и на тракте).
