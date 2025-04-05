SELECT
    {{ dbt_utils.generate_surrogate_key(['VENDOR_ID']) }} AS VENDOR_ID,
    VENDOR_ID AS VENDOR_NAME
FROM {{ ref('taxi_trips_consistent') }}
