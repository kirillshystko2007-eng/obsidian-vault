# Testing Game AI / Тестирование игрового ИИ

## Уровни тестирования
- Unit: переходы FSM, utility scoring, planner.
- Integration: perception → decision → movement.
- Scenario: NPC выполняет заданный сценарий.
- Regression: поведение не сломалось после изменения.
- Performance: CPU, memory, path requests, model latency.
- Playtest: качество поведения глазами игрока.

## Метрики
- Task success rate.
- Time-to-goal.
- Path length / detours.
- Detection precision/recall.
- Stuck rate.
- Decision frequency.
- RL reward distribution и variance.
- LLM latency, timeout rate, cost per session.

## Reproducibility
Сохраняйте seed, версию движка, конфиг AI, версию модели и начальное состояние мира.

## Debug visualization
Показывайте навигационный путь, поле зрения, активное состояние, score действий, Blackboard и причины переходов.

## Антипаттерны
- NPC читает скрытые координаты игрока.
- Агент застревает, но не имеет recovery.
- RL reward поощряет exploit.
- LLM напрямую меняет game state.
- Генератор создаёт непроходимые уровни.
