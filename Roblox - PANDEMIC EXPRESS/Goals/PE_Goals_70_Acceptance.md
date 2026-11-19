---
tags: [roblox, pandemic-express, goals, acceptance]
status: in progress
---
# G7 — Критерии приёмки всего проекта

Родитель: [[PE_Goals_00_Roadmap]]. Закрывается после [[PE_Goals_10_FirstIsland_Buildings]], [[PE_Goals_30_SecondIsland_World]] и [[PE_Goals_60_Transport_Integration]]. Сценарии: [[PE_Goals_71_Review_Matrix]].

## Первая локация

- Реестр [[PE_Goals_11_Building_Inventory]] показывает каждое здание в согласованной границе.
- Каждое здание прошло эталон [[PE_Goals_12_Building_Standard]] и проверено в окружении.
- Входы, лестницы, окна, interactivity, collision и ночная читаемость работают.
- Скрин/статус до-после сохранён для каждого объекта.

## Второй остров

- Все локации перечислены в [[PE_Goals_21_Island_Masterplan]] и карточках [[PE_Goals_22_Location_Brief]].
- Есть города, природные зоны, проходы, ориентиры и исследовательский цикл.
- Zone/spawn/travel markers названы и привязаны к документированной Location.
- Игрок может пройти от прибытия по основным маршрутам и вернуться.

## Поезда и совместный цикл

- Train1 проходит route на утверждённой высоте; рельсы появляются впереди и исчезают позади в bounded window.
- Группа входит в Train2, использует места, видит статус/назначение, прибывает в Main и возвращается обратно.
- Capacity, late arrivals, смерть, disconnect, reset, abort и ошибочный marker обработаны.
- Нет застрявших Anchored root, занятого slot, дублированных prompt/teleport, runaway rails или старых поездочных GUI.
- Старый TravelService либо безопасно мигрирован, либо отделён по явным правилам.

Все пункты должны быть проверены в согласованном Play-test сценарии и на целевом числе пассажиров; до этого статус `planned/in progress`, не `done`. Набор сценариев описан в [[PE_Goals_71_Review_Matrix]].
