---
tags: [roblox, pandemic-express, death]
---
# Downed и смерть
Связано: [[PE 05 - Персонаж и респавн]], [[PE 07 - Анимации]], [[PE 11 - Урон и киллы]], [[PE 20 - HUD]].

Подтверждена кастомная смерть: `R6Spawn` обслуживает `ReplicatedStorage.DownedResetRequest`; `CharacterAnimator` перенаправляет кнопку Reset с CoreGui на этот remote. Модуль `ServerScriptService.DeathAnimations` используется `R6Spawn` и `NPCAnimator`; клиентские `DeathScreen` и `CorpseHands` добавляют визуальный экран/эффект удаления тела.

Атрибут `Downed` служит guard для критических действий: `TravelService` и `ArmoryService` отказывают при `Downed=true`. Значит изменение downed state затрагивает поезд и арсенал, даже если UI не меняется.

### Разобрать в исходнике при следующем заходе

1. Точный переход `Humanoid.Health <= 0` → Downed/Death; кто задаёт и кто очищает атрибут.
2. Есть ли окно, в котором игрок downed, но тело ещё живо; какие tools отключены.
3. Условия manual reset и что считается abandon.
4. Cleanup corpse/root и момент следующего `CharacterAdded`.
5. Сохраняются ли `Cash`, `Kills`, `Stance`, `LastStation` после respawn.
6. Проверить смерть во время armory/train, чтобы anchored root или camera не застряли.

Не считать название `Downed` полным описанием механики без чтения `R6Spawn`. См. [[PE 04 - Сетевые контракты]] и [[PE 07 - Анимации]].
