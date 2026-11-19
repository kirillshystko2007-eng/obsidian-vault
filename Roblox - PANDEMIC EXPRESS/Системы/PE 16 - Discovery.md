---
tags: [roblox, pandemic-express, exploration]
---
# Discovery: открытие локаций
Связано: [[PE 04 - Сетевые контракты]], [[PE 17 - Деньги]], [[PE 20 - HUD]], [[PE 22 - География зон]].

`ReplicatedStorage.Zones` содержит объёмные Parts. HUD определяет локальный CurrentZone; `LocationTitles` показывает карточку. Авторитетный `DiscoveryService` строит список частей с непустым string-атрибутом `Subtitle`, каждую 1.5 секунды проверяет root игрока в oriented box зоны (`CFrame:PointToObjectSpace` + Size/2) и держит `discovered[player]` в session table.

Первое посещение каждой зоны за сессию: пометить зону, пересчитать count, установить player attrs `Discovered` / `DiscoverTotal`, прибавить 25 к `Cash`, вызвать `DiscoveryRemote(name,count,total,reward)`. `LocationTitles` показывает discovery награду на карточке. Table очищается при PlayerRemoving; межсерверное сохранение в просмотренном коде не видно.

В `Zones` 14 parts; `CANYON CROSSING STATION` имеет пустой Subtitle и поэтому не включается в серверный discoverable list. Вложенные/перекрывающиеся зоны могут конкурировать за CurrentZone, но server и HUD проверяют разными методами. Повтор карточки после cooldown не должен давать награду повторно. См. [[PE 22 - География зон]] и [[PE 17 - Деньги]].
