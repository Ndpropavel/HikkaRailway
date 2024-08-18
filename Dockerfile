FROM python:3.8-slim-buster as main
ENV RAILWAY=true
ENV DOCKER=true
ENV GIT_PYTHON_REFRESH=quiet
ENV PIP_NO_CACHE_DIR=1

# Установка зависимостей, включая uuid-runtime для генерации случайного UUID
RUN apt update && apt install libcairo2 git uuid-runtime -y --no-install-recommends

# Очистка ненужных файлов
RUN rm -rf /var/lib/apt/lists /var/cache/apt/archives /tmp/*

# Генерация случайного имени для директории
RUN export RANDOM_DIR=$(uuidgen | cut -c1-8) && \
    git clone https://github.com/hikariatama/Hikka /Hikka-${RANDOM_DIR}

WORKDIR /Hikka-${RANDOM_DIR}
RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN pip install --no-warn-script-location --no-cache-dir redis
EXPOSE 8080
RUN mkdir /data

CMD ["python3", "-m", "hikka"]
