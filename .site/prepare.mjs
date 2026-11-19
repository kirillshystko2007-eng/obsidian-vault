// Runs before `quartz build` on a COPY of the vault (CI checkout or a local test copy).
// Turns the home note "-.md" into the site's index.md: obsidian:// links become wikilinks,
// plus a header with the cosmos link and how to join. The vault itself is never edited.
// usage: node prepare.mjs <content dir> [repo url]
import fs from 'node:fs'; import path from 'node:path';
const [dir, repo = ''] = process.argv.slice(2);
const homeFile = path.join(dir, '-.md');
let home = fs.existsSync(homeFile) ? fs.readFileSync(homeFile, 'utf8') : '# Главная\n';

home = home
  .replace(/\[([^\]]+)\]\(obsidian:\/\/open\?([^)]+)\)/g, (m, text, q) => {
    const file = new URLSearchParams(q).get('file');
    return file ? `[[${file}|${text}]]` : text;
  })
  .replace(/^#\s+Главная\s*\n/, '')
  .replace(/^>.*obsidian:\/\/.*\n/m, '');

const header = `---
title: Главная
---

> [!tip] Граф целиком
> <a href="./cosmos/">🌌 Открыть Vault Cosmos</a> — всё хранилище в виде живых 3D-галактик. Двойной клик по звезде открывает заметку.

`;
const join = `
## Как участвовать
1. Установи [Obsidian](https://obsidian.md) и [Git](https://git-scm.com).
2. Склонируй хранилище: \`git clone ${repo || '<ссылка на репозиторий>'}\` и открой папку в Obsidian как хранилище.
3. Плагин **Obsidian Git** уже настроен: он сам забирает чужие правки и отправляет твои. Без права записи в репозиторий присылай изменения через pull request.
4. Через пару минут после отправки сайт и граф обновятся сами.
`;
fs.writeFileSync(path.join(dir, 'index.md'), header + home.trim() + '\n' + join);
if (fs.existsSync(homeFile)) fs.rmSync(homeFile);
console.log('index.md written');
