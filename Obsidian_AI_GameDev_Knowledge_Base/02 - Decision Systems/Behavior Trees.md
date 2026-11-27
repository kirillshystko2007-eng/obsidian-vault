# Behavior Trees (BT) / Деревья поведения

BT задаёт поведение через дерево узлов, которое выполняется с корня. Часто применяется для сложных NPC-последовательностей.

## Базовые узлы
- **Sequence**: выполняет детей по порядку; обычно завершается Failure при неудаче ребёнка и Success, когда все успешны.
- **Selector / Fallback**: пробует детей по очереди до Success (или Running).
- **Condition**: проверяет условие.
- **Action**: выполняет действие.
- **Decorator**: изменяет выполнение дочернего узла.
- **Service**: периодически обновляет контекст (терминология зависит от реализации).

## Статусы
Success, Failure, Running. Точные правила tick/abort зависят от конкретной BT-библиотеки или движка.

## Пример дерева
Selector
- Sequence: IsEnemyVisible → ChaseEnemy
- Sequence: HeardNoise → InvestigateNoise
- Patrol

## Blackboard
Хранилище данных, например TargetActor, LastKnownLocation, Health, AlertLevel. Не превращайте его в неограниченный глобальный контейнер.

## Плюсы и ограничения
BT масштабируются лучше длинного FSM при сложной иерархии действий, но требуют дисциплины в структуре, частоте tick и отладке.

## Engine mapping
Unreal имеет встроенные Behavior Trees и Blackboard. Для Unity/Godot можно написать собственную систему или выбрать библиотеку; проверяйте поддержку и лицензию.

См. [[GOAP]], [[Finite State Machines]], [[Utility AI]], [[Unreal Engine AI]].
