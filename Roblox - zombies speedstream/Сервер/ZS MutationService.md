---
tags: [roblox, zombies-speedstream, map, server]
snapshot: 2026-11-19
---
# MutationService

Карта: [[ZS 08 - Карта плейса]] · кластер **Сервер**

10 боевых мутаций: капсулы, слоты Z/X/C, уровни, эволюция за DNA; каст в забеге проверяет сервер.

| | |
|---|---|
| Путь | `ServerScriptService.Services.MutationService` |
| Класс | ModuleScript |
| Строк | 1004 |

## Подключает (require)
- [[ZS Config]]
- [[ZS DataService]]
- [[ZS MutationDefs]]
- [[ZS Net]]

## Кто подключает
- [[ZS Main]]
- [[ZS RunSessionService]]

## Ремоуты
- [[ZS ремоут RunRequest]]
- [[ZS ремоут RunEvent]]

## Net-действия (через [[ZS ремоут ShopRequest]])
`MutCapsule`, `MutEquip`, `MutUnequip`, `MutUpgrade`, `MutEvolve`
