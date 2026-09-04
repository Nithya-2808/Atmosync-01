# Known Issues

## Superset + Snowflake Driver
Superset's default Docker image runs Python from a virtual environment at /app/.venv,
but this path isn't available during image build time. Currently investigating the
correct install location for the snowflake-sqlalchemy driver to persist properly.



## Update
Root cause identified: Superset's Docker image runs Python from a virtual
environment at /app/.venv, but this path does not exist during the Docker
build stage. Attempting a corrected Dockerfile install path.