# Используем официальный образ MySQL
FROM mysql:latest

# Устанавливаем переменные окружения
ENV MYSQL_ROOT_PASSWORD = admin
ENV DB_DATABASE=laravel
ENV DB_USERNAME=root
ENV DB_PASSWORD=

# Копируем файл с инициализацией базы данных
COPY teatr.sql /docker-entrypoint-initdb.d/

# Опционально: пробрасываем порт базы данных
EXPOSE 3306
