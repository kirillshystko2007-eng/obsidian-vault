---
type: concept
difficulty: beginner
tags: [game-ai, foundations]
---

# Game AI - Overview / Обзор игрового ИИ

## Определение
**Game AI** — набор алгоритмов и систем, управляющих игровыми сущностями, выбором действий, навигацией, адаптацией и генерацией контента. В играх «интеллект» часто означает убедительное и управляемое поведение, а не человеческое мышление.

## Основные задачи
- Navigation: добраться до цели.
- Decision-making: выбрать действие.
- Perception: получить сведения о мире.
- Coordination: работать группой.
- Adaptation: подстроиться под игрока.
- Content generation: создавать уровни, предметы и события.

## Классический AI и ML
**Rule-based AI** использует явно заданные правила: FSM, Behavior Trees, GOAP.
**Machine Learning** строит модель по данным или взаимодействию: supervised learning, imitation learning, reinforcement learning.
Это взаимодополняющие подходы, а не взаимоисключающие.

## Базовая архитектура NPC
1. Sensors / Perception собирают информацию.
2. World Model / Blackboard хранит релевантное состояние.
3. Decision System выбирает намерение.
4. Planner или Navigation строит маршрут.
5. Controller исполняет действие.
6. Telemetry и tests измеряют результат.

См. [[NPC Architecture]], [[AI Perception]], [[Behavior Trees]], [[Reinforcement Learning - Overview]].

## Практическое упражнение
Создайте NPC, который патрулирует, замечает игрока, преследует его и возвращается к патрулю. Сначала реализуйте FSM, затем Behavior Tree. Сравните читаемость, отладку и расширяемость.

## English terminology
Game AI, agent, NPC, decision-making, perception, navigation, planner, controller, policy, inference.
