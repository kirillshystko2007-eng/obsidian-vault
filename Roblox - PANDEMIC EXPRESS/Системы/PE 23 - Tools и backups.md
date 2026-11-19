---
tags: [roblox, pandemic-express, tools, storage]
---
# Tools, шаблоны и backups
Связано: [[PE 08 - Револьвер]], [[PE 10 - Fists]], [[PE 14 - Арсенал]], [[PE 21 - Структура карты]], [[PE 26 - Очередь аудита]].

`ServerStorage` содержит `Revolver`, `Fists`, `ZombieTemplate`, `ArmoryRoom`, `RevolverSkins`, `FrontierLocations`, билдеры Dead Frontier/Western City, lighting backup и множество архивов. `PickupRespawner` заново создаёт перечисленные world tools после удаления/подбора; names задаются `NAMES` или атрибутом `RespawnTime` на Tool. World tools могут иметь собственные Scripts/LocalScripts; шаблон и размещённый clone должны быть проверены оба.

### Архивы — не текущий код

`ServerStorage._AnimBackup` и `_Backups` содержат датированные версии (pre_*, GOOD_SNAPSHOT, Overhaul). При поиске `HUD`, `CharacterAnimator`, `RevolverAnimation` результаты из архива часто многочисленнее активных. Сначала проверять точный active path: `ServerScriptService.*`, `StarterPlayerScripts.*`, `ServerStorage.Revolver.*`, `ServerStorage.Fists.*`, `ServerStorage.ZombieTemplate.*`. Не удалять архивы при очистке без явного запроса; использовать только для сравнения/восстановления. См. [[PE 26 - Очередь аудита]].
