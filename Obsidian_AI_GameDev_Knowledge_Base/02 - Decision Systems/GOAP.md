# GOAP — Goal-Oriented Action Planning / Планирование действий по целям

GOAP выбирает последовательность действий, которая приводит мир к желаемому состоянию.

## Модель
- World State: факты о мире.
- Goal: желаемые условия.
- Action: Preconditions + Effects + Cost.
- Planner: ищет последовательность действий.

Пример:
Goal: HasWeapon = true.
Action FindWeapon: precondition WeaponVisible=true; effect HasWeapon=true; cost=2.
Action OpenDoor: precondition DoorLocked=false; effect RoomAccessible=true; cost=1.

## Процесс
1. Собрать текущее состояние.
2. Выбрать цель.
3. Построить граф достижимых состояний.
4. Найти план с минимальной стоимостью.
5. Выполнить первое действие.
6. При изменении мира перепланировать.

## Важные решения
- Как кодируются состояния?
- Какие действия обратимы?
- Как учитывать риск, время и ресурсы?
- Когда план инвалидируется?
- Как ограничить пространство поиска?

## Сравнение
FSM кодирует переходы явно; BT задаёт структуру поведения; GOAP планирует цепочку действий из эффектов и предусловий.

См. [[Utility AI]], [[Behavior Trees]], [[NPC Architecture]].
