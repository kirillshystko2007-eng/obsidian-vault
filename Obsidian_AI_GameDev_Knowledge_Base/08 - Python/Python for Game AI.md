# Python for Game AI / Python для игрового ИИ

Python часто используется для обучения, экспериментов, анализа телеметрии и подготовки данных, даже если runtime игры написан на C#, C++ или GDScript.

## Основные инструменты
- NumPy: численные массивы.
- pandas: табличные данные и телеметрия.
- Matplotlib: графики обучения и метрик.
- PyTorch: нейросети и обучение.
- Gymnasium: интерфейс сред RL.
- PettingZoo: multi-agent environments.
- Jupyter: исследовательские эксперименты.

## Рекомендуемая структура проекта
```text
ai-training/
  configs/
  environments/
  agents/
  models/
  datasets/
  evaluation/
  notebooks/
  reports/
```

## Практика
Сделайте headless-среду с observation/action/reward, прогоняйте тысячи эпизодов без рендеринга и сохраняйте метрики. Экспортируйте обученную policy в формат, поддерживаемый целевым runtime.

## Важно
Закрепляйте версии зависимостей и сохраняйте конфигурацию эксперимента. Совместимость ML пакетов с Python и движком меняется.
