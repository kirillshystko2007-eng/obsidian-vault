# MM 28 — Игра теперь называется SunWave_rider (0.8.9)

Бывшая «Моно Мото / Mono Moto». Папка проекта: `Desktop\Sunwave rider 0.8`. → [[MM 18 - История версий]], [[MM 22 - Сборки ПК мобилка exe]]

## Что переименовано
- Заголовок вкладки/окна, `apple-mobile-web-app-title`, `application-name`, имя PWA в `manifest.webmanifest` → **SunWave_rider**.
- Логотип в меню: **SUNWAVE_ / RIDER** (шрифт уменьшен, т.к. слово длиннее — помещается на ПК и на телефоне).
- exe: **`SunWave_rider.exe`** (в `pc\`), свойства файла: ProductName/Title = SunWave_rider; заголовок окна тоже.
- Мобильный архив: **`SunWave_rider-<версия>-mobile.zip`**.
- Набор сборки `Desktop\MM First build`: `build.ps1`, `make-platforms.ps1`, `src\Program.cs` (копии старых — `*.bak-monomoto`).

## Что специально НЕ менялось (чтобы не пропали сохранения)
- Ключ сохранения `mono-moto-v1` (localStorage), папка данных exe `%LOCALAPPDATA%\MonoMoto`, внутренний хост `monomoto.example`, префикс кэша `mono-moto-` в `sw.js`. Прогресс, режим разработчика и настройки сохраняются.

![[mm089-sunwave-menu.png]]
