WITH containers AS (
    SELECT DISTINCT container_id
    FROM {{ ref('stg_container_telemetry') }}
)

SELECT
    container_id,
    CASE MOD(ABS(HASH(container_id)), 4)
        WHEN 0 THEN 'Los Angeles'
        WHEN 1 THEN 'Mexico City'
        WHEN 2 THEN 'Chicago'
        WHEN 3 THEN 'Houston'
    END AS origin_market
FROM containers