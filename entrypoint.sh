#!/bin/sh

# Загрузка переменной окружения с именем случайной директории
./random_dir.env

# Переход в директорию со случайным именем
cd /Hikka-${RANDOM_DIR}

# Установка зависимостей
pip install --no-warn-script-location --no-cache-dir -r requirements.txt
pip install --no-warn-script-location --no-cache-dir redis

# Запуск основного процесса
exec python3 -m hikka
