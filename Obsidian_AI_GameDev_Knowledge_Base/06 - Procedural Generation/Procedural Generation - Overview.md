# Procedural Generation / Процедурная генерация

Procedural Content Generation (PCG) создаёт игровой контент алгоритмически по правилам, параметрам и/или seed.

## Типы контента
Уровни, комнаты, ландшафты, подземелья, квесты, предметы, растения, города, диалоги и encounter compositions.

## Подходы
- Rule-based generation: грамматики и правила.
- Noise-based: Perlin/Simplex и фрактальные шумы.
- Cellular automata: например, пещеры.
- Graph-based: структура комнат/квестов.
- Constraint-based: удовлетворение ограничений.
- Wave Function Collapse: локальные ограничения совместимости паттернов.
- Search/evolutionary: оптимизация по fitness.
- ML-based generation: модели, обученные на примерах.

## Pipeline
Parameters + seed → generation → validation → scoring → repair/regeneration → content package.

## Ключевые требования
- Воспроизводимость по seed.
- Контроль качества и проходимости.
- Ограничения сложности/ресурсов.
- Ручная правка и authoring tools.
- Сохранение provenance и версии генератора.

## Практика
Сгенерируйте сетку комнат, соедините графом, проверьте связность, доступность выхода и достижимость ключа. Затем добавьте визуальное оформление.

Источник для изучения WFC: [[GitHub - WaveFunctionCollapse]].
