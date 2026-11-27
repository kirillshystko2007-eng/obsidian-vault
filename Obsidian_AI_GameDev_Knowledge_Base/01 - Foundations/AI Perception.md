# AI Perception / Восприятие игрового мира

Perception превращает сырые сигналы мира в сведения, пригодные для решений NPC.

## Каналы восприятия
- Vision: угол обзора, дальность, line-of-sight, препятствия.
- Hearing: событие шума, громкость, затухание по расстоянию.
- Proximity: overlap/radius trigger.
- Damage / threat: источник урона и уровень угрозы.
- Game events: тревога, открытие двери, союзный сигнал.

## Не путайте обнаружение и знание
NPC мог увидеть игрока в точке X, но после потери видимости должен помнить **последнюю известную позицию**, а не читать актуальную позицию игрока напрямую. Это важно для честного поведения.

## Практический алгоритм зрения
1. Проверить расстояние.
2. Проверить угол между forward и направлением на цель.
3. Выполнить raycast/line trace.
4. Применить правила команды, маски и stealth.
5. Обновить confidence и timestamp наблюдения.

## Метрики
Detection latency, false positive rate, false negative rate, время потери цели, стоимость raycasts.

## Engine mapping
- Unreal: AI Perception system.
- Unity: собственные сенсоры/physics queries или сторонние решения.
- Godot: Area3D, raycasts, physics queries и собственная логика.

См. [[NPC Architecture]], [[Unreal Engine AI]], [[Unity AI]], [[Godot AI]].
