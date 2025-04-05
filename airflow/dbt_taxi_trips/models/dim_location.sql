WITH TAXI_TRIPS_LOCATIONS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['PICKUP_LATITUDE', 'PICKUP_LONGITUDE']) }} AS LOCATION_ID,
        PICKUP_LATITUDE AS LATITUDE,
        PICKUP_LONGITUDE AS LONGITUDE
    FROM {{ ref('taxi_trips_consistent') }}
    UNION
    SELECT
        {{ dbt_utils.generate_surrogate_key(['DROPOFF_LATITUDE', 'DROPOFF_LONGITUDE']) }} AS LOCATION_ID,
        DROPOFF_LATITUDE AS LATITUDE,
        DROPOFF_LONGITUDE AS LONGITUDE
    FROM {{ ref('taxi_trips_consistent') }}
)

SELECT * FROM (
    {{ dbt_utils.deduplicate(
         relation = 'TAXI_TRIPS_LOCATIONS',
         partition_by = 'LOCATION_ID',
         order_by = 'LATITUDE'
         )
    }}
)
