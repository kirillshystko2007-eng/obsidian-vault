---
tags: [roblox, pandemic-express, ui]
---
# HUD и ввод
Связано: [[PE 03 - Клиентские контроллеры]], [[PE 04 - Сетевые контракты]], [[PE 14 - Арсенал]], [[PE 15 - Поезд]], [[PE 16 - Discovery]], [[PE 17 - Деньги]].

`StarterPlayerScripts.HUD` скрывает стандартный Health/Backpack CoreGui и программно строит собственную панель. `StarterGui` пуст на снимке. Цвета/размеры берутся из `ReplicatedStorage.PandemicHUD.Theme` (`Colors`, `Layout`, `Clean`, `Glass`). HUD читает атрибуты здоровья/денег/киллов/зоны и глобально подправляет текстовые элементы; локальные экраны создают `ArmoryClient`, `TravelClient`, `LocationTitles`, `StanceMenu`, `DeathScreen`, `EmoteWheel`.

UI и camera/input сцеплены: `InArmory` освобождает cursor и отдаёт камеру ArmoryClient; `StanceMenuOpen` останавливает поворот камеры. Переезд использует DisplayOrder 900 и fade; интро использует ранний cover; HUD должен уважать оба состояния.

При правке проверить масштабирование, safe area, клавиатуру/геймпад/мобильные вводы, обработку `gameProcessed`, TextBox, повторное создание после respawn, глобальную `BrokenTextMask` и z-order. Сервер должен рассчитывать деньги/покупку/попадание; HUD только отображает. См. [[PE 04 - Сетевые контракты]].

### Обновление 2026-11-09 — сумка и часы
`StarterPlayerScripts.BagClient` (ScreenGui `BagUI`): кнопка-мешок справа по центру, **Tab** или клик открывает панель «руки 4 / сумка 6». Пока открыта — атрибут игрока `BagOpen`: HUD не поворачивает камеру, `MouseControl` освобождает курсор. CoreGui **PlayerList отключён** (Tab занят сумкой). Колесо HUD (1–4) видит только прямых детей Backpack/Character, поэтому предметы в `Backpack.Bag` в нём не появляются. Часы `PocketWatch` рисуют свой ScreenGui `PocketWatchUI`. Отчёт: [[PE Отчёт 2026-11-09 — Прицел от 3-го лица, сумка, карманные часы]]
