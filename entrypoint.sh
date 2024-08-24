#!/bin/sh

PORT=$(shuf -i 1000-9999 -n 1)
# Генерация случайного 4-значного числа
# Печать сгенерированного порта
echo "Случайный порт: ${PORT}"

# Загрузка переменной окружения с именем случайной директории
chmod 777 /random_dir.env
. /random_dir.env
export PORT
# Проверка существования директории и переход в нее
if [ -d "${RANDOM_DIR}" ]; then
    cd "${RANDOM_DIR}"
else
    echo "Directory ${RANDOM_DIR} does not exist"
    exit 1
fi

# Установка зависимостей
if [ -f "requirements.txt" ]; then
    pip install --no-warn-script-location --no-cache-dir -r requirements.txt
    pip install --no-warn-script-location --no-cache-dir redis
else
    echo "requirements.txt not foun"
    exit 1
fi

# Запуск основного процесса с указанием случайного порта
exec python -m hikka --port "${PORT}"
