# Atmosync-01









Real-time IoT streaming pipeline for micro-climate supply chain analytics.



\## Stack

\- Apache Kafka (streaming ingestion)

\- Snowflake (data warehouse)

\- dbt (transformation)

\- Apache Superset (visualization)



\## Progress

\- Kafka + Zookeeper running via Docker Compose

\- Python IoT simulator streaming container telemetry every second

\- - Kafka to Snowflake ingestion bridge implemented and verified working end-to-end



## Week 1 Status

* Snowflake account activated, database/schema/table created
* Kafka to Snowflake pipeline verified end-to-end with live data
* Superset installed via Docker; currently resolving Snowflake driver integration

&#x20;

\## Architecture

Python IoT Simulator -> Apache Kafka -> Python Ingestion Bridge -> Snowflake -> Superset (in progress)





\## Week 1 - COMPLETE

\- Kafka + Zookeeper streaming pipeline verified

\- Snowflake data warehouse storing live sensor data

\- Superset connected to Snowflake and successfully querying data

\- All Week 1 deliverables (Ingestion Architecture + BI Foundations) finished

## Update - Docker Build Network Issue

Discovered that Docker's build-time process cannot reach the internet on this
machine (Network is unreachable error), even though regular running containers
have internet access. Switching strategy to install the Snowflake driver into
a live running container instead of during image build.

