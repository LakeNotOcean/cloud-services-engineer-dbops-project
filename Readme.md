# dbops-project
Репозиторий для выполнения проекта дисциплины "DBOps"


# Настройка БД

Для успещного применения миграций необходимо:

1. Создать БД:
    ```
    CREATE DATABSE <DB_NAME>;
    ```
2. Создать пользователя БД для применения миграций и прохождения автотестов:
    ```
    CREATE ROLE <DB_USER> WITH LOGIN PASSWORD '<DB_PASSWORD>';
    ```
3. Выдать доступ ко всем привелегиям сервисному пользователю миграции:
    ```
    GRANT ALL PRIVILEGES ON DATABASE <DB_NAME> TO <DB_USER>;
    ```
