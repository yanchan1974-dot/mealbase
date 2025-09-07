FROM python:3.11-slim

WORKDIR /app
# Кладём твой ZIP внутрь образа
COPY mealbase-starter.zip /app/

# Нужен unzip, распакуем ZIP и поставим зависимости
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/* \
    && unzip -o mealbase-starter.zip \
    && pip install --no-cache-dir -r mealbase-starter/requirements.txt

# Папка для данных
ENV DATA_DIR=/app/mealbase-starter/data

EXPOSE 10000
# Запуск API. Render подставит $PORT автоматически.
CMD ["bash","-lc","cd mealbase-starter && uvicorn app.main:app --host 0.0.0.0 --port ${PORT:-10000}"]
