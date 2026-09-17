WITH risk AS (
    SELECT
        container_id,
        AVG(temperature_c) AS avg_temperature_c,
        AVG(humidity_pct) AS avg_humidity_pct,
        AVG(spoilage_risk_score) AS avg_spoilage_risk_score,
        MIN(time_to_spoilage_hours) AS time_to_spoilage_hours
    FROM {{ ref('int_container_spoilage_risk') }}
    GROUP BY container_id
),

market_assignment AS (
    SELECT * FROM {{ ref('int_container_market_assignment') }}
),

distances AS (
    SELECT * FROM {{ ref('market_distances') }}
),

pricing AS (
    SELECT
        market,
        AVG(price_per_kg) AS avg_price_per_kg
    FROM {{ ref('commodity_prices') }}
    WHERE commodity = 'avocado'
    GROUP BY market
),

combined AS (
    SELECT
        r.container_id,
        r.avg_temperature_c,
        r.avg_humidity_pct,
        r.avg_spoilage_risk_score,
        r.time_to_spoilage_hours,
        ma.origin_market,
        d.destination_market,
        d.distance_km,
        d.travel_hours,
        p_origin.avg_price_per_kg AS origin_price,
        p_dest.avg_price_per_kg AS destination_price
    FROM risk r
    JOIN market_assignment ma ON r.container_id = ma.container_id
    JOIN distances d ON ma.origin_market = d.origin_market
    JOIN pricing p_origin ON ma.origin_market = p_origin.market
    JOIN pricing p_dest ON d.destination_market = p_dest.market
)

SELECT
    container_id,
    avg_temperature_c,
    avg_humidity_pct,
    avg_spoilage_risk_score,
    time_to_spoilage_hours,
    origin_market,
    destination_market,
    distance_km,
    travel_hours,
    origin_price,
    destination_price,
    (destination_price - origin_price) AS price_delta,
    CASE
        WHEN time_to_spoilage_hours < travel_hours THEN TRUE
        ELSE FALSE
    END AS at_risk_of_spoiling_before_arrival,
    CASE
        WHEN time_to_spoilage_hours < travel_hours
             AND destination_price > origin_price
        THEN TRUE
        ELSE FALSE
    END AS arbitrage_opportunity
FROM combined