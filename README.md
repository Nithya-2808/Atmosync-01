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



&#x20;

\## Architecture

Python IoT Simulator -> Apache Kafka -> Python Ingestion Bridge -> Snowflake -> Superset (in progress)

## Update - Docker Build Network Issue

Discovered that Docker's build-time process cannot reach the internet on this
machine (Network is unreachable error), even though regular running containers
have internet access. Switching strategy to install the Snowflake driver into
a live running container instead of during image build.





\## Week 1 - COMPLETE

\- Kafka + Zookeeper streaming pipeline verified

\- Snowflake data warehouse storing live sensor data

\- Superset connected to Snowflake and successfully querying data

\- All Week 1 deliverables (Ingestion Architecture + BI Foundations) finished



\## Progress Update



\*\*Week 1 — Ingestion \& BI Foundation (Complete)\*\*

\- Python IoT simulator generating mock container telemetry (temperature, humidity, vibration)

\- Kafka + Zookeeper streaming pipeline, verified end-to-end into Snowflake

\- Apache Superset deployed via Docker and connected to Snowflake



\*\*Week 2 — ELT Pipeline (In Progress)\*\*

\- dbt Core initialized and connected to Snowflake

\- Staging model (`stg\_container\_telemetry`) cleaning raw JSON payloads, with proper timestamp conversion

\- Mock commodity pricing data loaded as a dbt seed

\- Automated dbt data quality tests (not-null checks) passing on all key columns

\- Baseline Superset dashboards in progress



\*\*Next Steps\*\*

\- Build baseline visualization charts (temperature trends, container health)

\- Write dbt models to calculate spoilage arbitrage metrics

\- Build the arbitrage dashboard highlighting at-risk containers

\- Set up automation and alerting









