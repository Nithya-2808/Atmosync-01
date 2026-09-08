# Superset Setup Instructions

## Run Superset with Snowflake support
1. docker run -d -p 8088:8088 --name superset -e SUPERSET_SECRET_KEY=<key> apache/superset:latest
2. docker exec -u root -it superset pip3 install snowflake-sqlalchemy
3. docker exec -it superset python -c "import snowflake.sqlalchemy; print('OK')"
4. docker commit superset superset-snowflake
5. docker exec -it superset superset fab create-admin --username admin --firstname Admin --lastname User --email admin@admin.com --password admin
6. docker exec -it superset superset db upgrade
7. docker exec -it superset superset init

Access at localhost:8088