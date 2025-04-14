WITH TAXI_TRIPS_LOCATIONS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['PICKUP_LATITUDE', 'PICKUP_LONGITUDE']) }} AS LOCATION_ID,
        PICKUP_LATITUDE AS LATITUDE,
        PICKUP_LONGITUDE AS LONGITUDE,
        CREATED_TIMESTAMP AS UPDATED_TS
    FROM {{ ref('taxi_trips_consistent') }}
    UNION
    SELECT
        {{ dbt_utils.generate_surrogate_key(['DROPOFF_LATITUDE', 'DROPOFF_LONGITUDE']) }} AS LOCATION_ID,
        DROPOFF_LATITUDE AS LATITUDE,
        DROPOFF_LONGITUDE AS LONGITUDE,
        CREATED_TIMESTAMP AS UPDATED_TS
    FROM {{ ref('taxi_trips_consistent') }}
)

SELECT * FROM (
    {{ dbt_utils.deduplicate(
         relation = 'TAXI_TRIPS_LOCATIONS',
         partition_by = 'LOCATION_ID',
         order_by = 'UPDATED_TS DESC'
         )
    }})
{% if is_incremental() %}
WHERE UPDATED_TS > (
    SELECT COALESCE(MAX(UPDATED_TS), '{{ var('default_date') }}')
    FROM {{ this }}
)
{% endif %}
