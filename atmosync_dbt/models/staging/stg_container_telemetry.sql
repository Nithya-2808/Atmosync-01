SELECT
    raw_data:container_id::string AS container_id,
    raw_data:temperature_c::float AS temperature_c,
    raw_data:humidity_pct::float AS humidity_pct,
    raw_data:vibration::float AS vibration,
    raw_data:timestamp::float AS event_timestamp,
    DATEADD('second', raw_data:timestamp::float, '1970-01-01'::timestamp_ntz) AS event_time
FROM {{ source('raw', 'CONTAINER_TELEMETRY_RAW') }}