# PostgreSQL17
PostgreSQL integration with WEB-services (PL/Python -> HTTP method GET,POST and send e-mail, PL/pgSQL -> JSON, XML, CSV).
Add JSON Data Type (table, jsonb_path_query, json_build_object)

PostgreSQL 17 + Python 3.12.6
IDE - DBeaver
---------------------------------------------------------------------------------
Встановлення та налаштування:
---------------------------------------------------------------------------------
1) Встановлюємо Python 3
   - встановлюємо Python python-3.XX.XXX-amd64.exe
     -> Use admin privileges when installing py.exe - увімкнути
     -> Add python.exe to PATH - увімкнути
     -> !!!! Customize installation
     -> Next
     -> Install Python 3.XX for all user - увімкнути
     -> Install
     -> Disable MAX_LIMIT – виконати.
     -> Завершити
   Перевантажити комп'ютер.

2) Встановлюємо PostgreSQL (пароль: 12345678)

3) Розгортаємо базу даних:
     - Виконуємо скрипт .\1_create_db_and_user.bat (пароль: 12345678)
     - Виконуємо скрипт .\2_add_objects.bat (пароль: 12345678)

4) Створюємо з'єднання в DBeaver
   - хост: localhost
   - порт: 5432
   - база даних: test_database
   - Користувач: test_user
   - пароль: 12345678

5) Включаємо налагодження в PostgreSQL

   C:\Program Files\PostgreSQL\XX\data\postgresql.conf правимо файл - міняємо
   з
    #shared_preload_libraries = ''# (change requires restart)
   на
    shared_preload_libraries = 'plugin_debugger' # (change requires restart)
   - Перезавантажити сервер.

---------------------------------------------------------------------------------
Backup (pgAdmin 4)
---------------------------------------------------------------------------------
   - Запускаємо pgAdmin 4
   - Servers -> Dashboard -> Configure pgAdmin -> Patch -> Binary patch
   - Поле PostgreSQL Binary Path = C:\Program Files\PostgreSQL\XX\bin
   - На базі виконати Backup

---------------------------------------------------------------------------------
Backup (DBeaver)
---------------------------------------------------------------------------------
   - На базі правою клавішею -> Tools -> Backup
   - Зберігається в C:\Users\Admin\dump-test_database-XXXXXXXXXXXX.sql (приклад)
