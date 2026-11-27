# Unreal Engine AI / Игровой ИИ в Unreal Engine

## Основные системы
- AI Controller: контроллер NPC.
- Pawn/Character: управляемая сущность.
- Behavior Tree: дерево принятия решений.
- Blackboard: контекст и значения для BT.
- AI Perception: зрение, слух и другие stimuli.
- Navigation System / NavMesh: навигация.
- EQS (Environment Query System): выбор объектов/точек по запросам и тестам.

## Типовой паттерн
AI Controller запускает Behavior Tree; Blackboard хранит TargetActor и LastKnownLocation; AI Perception обновляет сведения; BT выбирает патруль, расследование, преследование или атаку.

## Практическое упражнение
Создать NPC, который:
1. Патрулирует между точками.
2. Обнаруживает игрока через perception.
3. Записывает цель в Blackboard.
4. Преследует игрока через Move To.
5. При потере видимости идёт к LastKnownLocation.
6. Возвращается к патрулю.

## Официальная документация
- AI systems: https://dev.epicgames.com/documentation/en-us/unreal-engine/artificial-intelligence-in-unreal-engine
- Behavior Trees: https://dev.epicgames.com/documentation/en-us/unreal-engine/behavior-trees-in-unreal-engine
- AI Perception: https://dev.epicgames.com/documentation/en-us/unreal-engine/ai-perception-in-unreal-engine
- EQS: https://dev.epicgames.com/documentation/en-us/unreal-engine/environment-query-system-in-unreal-engine

Проверяйте названия меню и API по версии Unreal Engine.
