SELECT
    raw_data:container_id::string AS container_id,
    raw_data:temperature_c::float AS temperature_c,
    raw_data:humidity_pct::float AS humidity_pct,
    raw_data:vibration::float AS vibration,
    raw_data:timestamp::float AS event_timestamp
FROM {{ source('raw', 'CONTAINER_TELEMETRY_RAW') }}