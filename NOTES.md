# Known Issues

## Superset + Snowflake Driver
Superset's default Docker image runs Python from a virtual environment at /app/.venv,
but this path isn't available during image build time. Currently investigating the
correct install location for the snowflake-sqlalchemy driver to persist properly.



## Update
Root cause identified: Superset's Docker image runs Python from a virtual
environment at /app/.venv, but this path does not exist during the Docker
build stage. Attempting a corrected Dockerfile install path.


## Update - Docker Build Network Issue
Discovered that Docker's build-time process cannot reach the internet on this
machine (Network is unreachable error), even though regular running containers
have internet access. Switched strategy: installing the Snowflake driver into
a live running container instead of during image build, then committing that
container as a new image.