---
tags: [roblox, pandemic-express, npc]
---
# NPC и анимация
Связано: [[PE 07 - Анимации]], [[PE 12 - Зомби]], [[PE 14 - Арсенал]], [[PE 21 - Структура карты]].

`ServerScriptService.NPCAnimator` применяет общий R6 player animation set к подходящим NPC. NPC исключается при `CustomAnimations=true`, наличии `Animate`, скрипте с `Anim`/`Idle` в имени или Animation object. `AnimSaves` само по себе не означает custom animation. Атрибут `CustomAnimations=false` позволяет принудить общий сет.

Атрибуты модели:
- `IdleAnimation="<name>"` — одиночный idle из `ReplicatedStorage.Animations` (пример: ArmoryOwner → `MerchantIdle`).
- `WalkAnimation="<name>"` — custom locomotion (пример для зомби: `ZombieWalk`; idle: `ZombieIdle`).
- Для NPC с revolver `Aiming=true/false` включает aim pose, смена `Shoot=os.clock()` запускает отдачу.

В Workspace найдены модели `Walker`, `Cultist`, `Sheriff`, `Flyer`, `Contrabandist`, `ArmoryOwner`; часть имеет свои idle scripts. Zombie AI находится в шаблоне, а не в NPCAnimator. При правке различай NPC animator, brain, tool script, spawn template. Убийство NPC проходит через [[PE 11 - Урон и киллы]], смерть через [[PE 06 - Downed и смерть]].
