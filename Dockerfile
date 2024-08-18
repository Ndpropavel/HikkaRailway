FROM python:3.8-slim-buster as main
ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Установка зависимостей, включая uuid-runtime для генерации случайного UUID
RUN apt update && apt install libcairo2 git uuid-runtime -y --no-install-recommends

# Очистка ненужных файлов
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Генерация случайного имени для директории и клонирование репозитория
RUN RANDOM_DIR=$(uuidgen | cut -c1-8) && \
    git clone https://github.com/hikariatama/Hikka /Hikka-${RANDOM_DIR} && \
    echo "RANDOM_DIR=/Hikka-${RANDOM_DIR}" > /random_dir.env

# Копирование и выполнение скрипта для установки зависимостей
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Поскольку EXPOSE не поддерживает динамическую подстановку, можно указать диапазон портов
EXPOSE 1000-9999

RUN mkdir /data

CMD ["/entrypoint.sh"]
