---
tags: [roblox, pandemic-express, animation, ui, revolver]
snapshot: 2026-11-12
---
# Эмоции, колесо B и доставание револьвера
Связано: [[PE 03 - Клиентские контроллеры]], [[PE 07 - Анимации]], [[PE 08 - Револьвер]], [[PE 09 - Dual stance]], [[PE 20 - HUD]], [[PE 28 - Прогрессия (гильдия и шериф)]] · отчёт: [[PE Отчёт 2026-11-12 — Анимации доставания револьвера (Draw 2, Draw 3, вращение)]]

Колесо на клавише **B**: сверху эмоции, снизу выбор того, **как персонаж достаёт револьвер**. Вне дорожной карты (полировка). Снимок сверён с живым плейсом 2026-11-12.

## Колесо (`StarterPlayerScripts.EmoteWheel`)
- **B** открывает и закрывает (`TOGGLE_KEY`). Круг из 8 слотов (`HALF_SLOTS = 4` на половину), стиль — пергамент и латунь, центр подписан «POSES».
- **Верхняя половина — EMOTES** (таблица `EMOTES`): клик проигрывает эмоцию. Движение, прыжок или клик по центру её останавливают.
- **Нижняя половина — ACTIONS** (таблица `ACTIONS`): клик ставит атрибут игрока (`attr = value`). Активный вариант подсвечен красным.

| Половина | Слот | Что | Клип |
|---|---|---|---|
| EMOTES | Sit 💺 | сесть; если сзади что-то ближе `BACK_DISTANCE = 2.6` — сесть, опершись спиной | `SitEmote` / `SitEmote2` |
| ACTIONS | Draw 1 🔫 | старое доставание | `Revolverdraw` |
| ACTIONS | **Draw 2** 🔫 (по умолчанию) | рука к кобуре → рывок, револьвер **2 оборота на пальце** → поймал → стойка | `Revolverequip2` |
| ACTIONS | Draw 3 ✨ | рука через грудь → выброс в сторону → **револьвер появляется в ладони** (блик + искры), 3 оборота → у бедра → стойка | `Revolverequip3` |

Свободно: 3 слота эмоций и 1 слот действий.

## Как выбранное доставание попадает в игру
1. Колесо ставит атрибут игрока **`RevolverEquipAnim`** = имя KeyframeSequence.
2. `ServerStorage.Revolver.RevolverAnimation` → `playDraw()` берёт клип из атрибута; пока атрибут пуст — `DEFAULT_EQUIP_ANIM = "Revolverequip2"` (держать в паре с `default = true` в `ACTIONS`). Смена атрибута с револьвером в руке = сразу новое доставание.
3. Клип заканчивается **ровно в позе `Revolveridle2`**, поэтому переход в стойку ничего не съедает.
4. Двойные револьверы (Stance 2, [[PE 09 - Dual stance]]) всегда играют `Dualrevolverdraw`.

## Вращение и появление (`ReplicatedStorage.RevolverSpin`)
Клиентский модуль. Револьвер держится сварным швом `RightGrip` (**Weld**), модуль каждый кадр поворачивает его `C1` вокруг `PIVOT = (0.2, 0.55, 0)` — скоба спуска в координатах `Handle`. Целое число оборотов → револьвер возвращается точно в хват.

Настройка по клипам: `M.CLIPS[имя] = { start, finish, turns, appear?, blend? }`
- `appear` — до этого момента детали револьвера локально прозрачны (Draw 3: 0.46 с);
- `blend` — свой вход клипа (Draw 3: 0.15 с вместо общих 0.45 с);
- выстрел, прицеливание или убирание во время вращения дозавершают оборот за ~0.1 с (`CANCEL_RATE`) и сразу возвращают видимость.

Эффект появления (Draw 3): мягкий блик **Glint**, 12 искр **Burst**, редкие искры **Trail** с вращающегося револьвера, слабый тёплый свет; цвет `FX_COLOR` — тёплое золото. Всё на `Attachment` в точке скобы, убирается через 1 с после ловли. Размеры — `FLASH_SIZE`, `FLASH_LIGHT`, `SPARKLES`, `SPARKLE_TRAIL` (0 выключает).

Чтобы вращение видели другие: `RemoteEvent ReplicatedStorage.RevolverDrawSpin` → `ServerScriptService.RevolverSpinRelay` (в руках Tool «Revolver», не чаще раза в 0.3 с) → `StarterPlayerScripts.RevolverSpinClient` на чужом персонаже.

## Где что лежит
| Что | Путь |
|---|---|
| Колесо | `StarterPlayerScripts.EmoteWheel` (`EMOTES`, `ACTIONS`, `TOGGLE_KEY`) |
| Доставание | `ServerStorage.Revolver.RevolverAnimation` → `playDraw()`, `DEFAULT_EQUIP_ANIM` |
| Клипы | `ReplicatedStorage.Animations.Revolverdraw / Revolverequip2 / Revolverequip3 / SitEmote / SitEmote2`; исходник Draw 2 — `ServerStorage.RBX_ANIMSAVES.Dummy1.revolverequip2` |
| Слои рук | `StarterPlayerScripts.CharacterAnimator` → `ARM_LAYERS` (иначе он глушит трек) |
| Вращение | `ReplicatedStorage.RevolverSpin`, `RevolverDrawSpin`, `ServerScriptService.RevolverSpinRelay`, `StarterPlayerScripts.RevolverSpinClient` |

## Добавить
- **Эмоцию**: KeyframeSequence в `ReplicatedStorage.Animations` + строка в `EMOTES`.
- **Доставание**: клип в `Animations` + строка в `ACTIONS` (`attr = "RevolverEquipAnim"`) + имя в `ARM_LAYERS`; нужно вращение — запись в `RevolverSpin.CLIPS`.

## Известные ограничения
- Выбор доставания живёт **только в сессии** (атрибут, не сохраняется в PlayerData).
- **B занята дважды**: колесо и звезда помощника шерифа (`ProgressionClient.STAR_KEY`, [[PE 28 - Прогрессия (гильдия и шериф)]]). У присягнувшего игрока срабатывает и то и другое.
- Убирание общее для всех вариантов (`Revolverunequip`).
- Вращение у других игроков не проверено (нужны 2 клиента). Для живых серверов клипы нужно опубликовать (AnimationId) — [[PE 27 - Дополнения и риски]].
