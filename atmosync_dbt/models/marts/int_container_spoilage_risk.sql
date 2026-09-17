WITH telemetry AS (
    SELECT
        container_id,
        temperature_c,
        humidity_pct,
        vibration,
        event_time
    FROM {{ ref('stg_container_telemetry') }}
),

risk_calc AS (
    SELECT
        container_id,
        temperature_c,
        humidity_pct,
        vibration,
        event_time,
        GREATEST(0, temperature_c - 7) + GREATEST(0, 4 - temperature_c) AS temp_deviation,
        GREATEST(0, humidity_pct - 90) + GREATEST(0, 85 - humidity_pct) AS humidity_deviation
    FROM telemetry
)

SELECT
    container_id,
    temperature_c,
    humidity_pct,
    vibration,
    event_time,
    temp_deviation,
    humidity_deviation,
    (temp_deviation * 2) + (humidity_deviation * 0.5) AS spoilage_risk_score,
    GREATEST(0, 120 - ((temp_deviation * 2 + humidity_deviation * 0.5) * 10)) AS time_to_spoilage_hours
FROM risk_calc