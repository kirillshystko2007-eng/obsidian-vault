# Godot AI / Игровой ИИ в Godot

## Основные возможности
- NavigationServer и navigation maps.
- NavigationAgent2D / NavigationAgent3D.
- AStarGrid2D и AStar3D.
- Area2D/Area3D и physics queries для сенсоров.
- Signals для событий.
- GDScript/C# для decision systems.

## Практическая архитектура
Perception node → Blackboard/resource → FSM или BT → NavigationAgent → CharacterBody movement.

## Учебный пример
Официальный godot-demo-projects содержит отдельный проект `2d/navigation_astar`; в описании указаны AStarGrid2D и Steering Behaviors для сглаживания движения.

## Ссылки
- Demos: https://github.com/godotengine/godot-demo-projects
- AStar demo: https://github.com/godotengine/godot-demo-projects/tree/master/2d/navigation_astar
- Docs: https://docs.godotengine.org/

Обратите внимание на ветки: master может соответствовать разрабатываемой версии Godot. Выбирайте ветку, соответствующую вашей стабильной версии.
