---
tags: [roblox, pandemic-express, weapons]
---
# Dual stance и второй револьвер
Связано: [[PE 04 - Сетевые контракты]], [[PE 07 - Анимации]], [[PE 08 - Револьвер]], [[PE 20 - HUD]].

Клиент `StarterPlayerScripts.StanceMenu` открывает меню и отправляет запрос через `ReplicatedStorage.StanceRequest`. Сервер `ServerScriptService.DualRevolver` сохраняет `Stance` (1/2), считает owned `Revolver` Tools в Backpack и Character и сбрасывает стойку 2 → 1, если оружий меньше двух.

При dual stance строится `LeftRevolver` в левой руке; grip берётся от `RightGripAttachment`. Поддержан R6 (`Left Arm`) и fallback R15 (`LeftHand`), но остальная игра в основном настроена на R6. Второй rig получает skin через Tool attribute `WeaponRig`; `RevolverAnimation` управляет клипами/flash.

### Edge cases

- второй Tool отсутствует, уничтожен, перемещён между Backpack/Character;
- игрок умер/respawn, Tool переэкипирован или сменил skin;
- запросы приходят подряд/с недопустимым значением;
- attachment/right grip отсутствует или тело Tool переименовано;
- HUD/камера/мышь блокируют меню через `StanceMenuOpen`.

Внешний вид второго пистолета не даёт права наносить второй урон сам по себе; основной shot pipeline остаётся в [[PE 08 - Револьвер]]. Проверить server validation и cleanup клона отдельно.
