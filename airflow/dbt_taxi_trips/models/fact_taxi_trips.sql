{{
    config(
        materialized = 'incremental',
        unique_key = ['VENDOR_ID', 'PICKUP_DATE_ID', 'PICKUP_LOCATION_ID'],
        on_schema_change = 'sync_all_columns',
        incremental_strategy = 'merge'
    )
}}

WITH FACT_TAXI_TRIPS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['VENDOR_ID']) }} AS VENDOR_ID,
        {{ dbt_utils.generate_surrogate_key(['PAYMENT_TYPE']) }} AS PAYMENT_TYPE_ID,
        {{ dbt_utils.generate_surrogate_key(['TPEP_PICKUP_DATETIME']) }} AS PICKUP_DATE_ID,
        {{ dbt_utils.generate_surrogate_key(['TPEP_DROPOFF_DATETIME']) }} AS DROPOFF_DATE_ID,
        {{ dbt_utils.generate_surrogate_key(['PICKUP_LATITUDE', 'PICKUP_LONGITUDE']) }} AS PICKUP_LOCATION_ID,
        {{ dbt_utils.generate_surrogate_key(['DROPOFF_LATITUDE', 'DROPOFF_LONGITUDE']) }} AS DROPOFF_LOCATION_ID,
        PASSENGER_COUNT,
        TRIP_DISTANCE,
        FARE_AMOUNT,
        EXTRA,
        MTA_TAX,
        TIP_AMOUNT,
        TOLLS_AMOUNT,
        IMPROVEMENT_SURCHARGE,
        TOTAL_AMOUNT,
        TRIP_DURATION_MINUTES,
        TRIP_SPEED_MPH,
        CREATED_TIMESTAMP AS UPDATED_TS
    FROM {{ ref('taxi_trips_consistent') }}
)

SELECT * FROM FACT_TAXI_TRIPS
{% if is_incremental() %}
WHERE UPDATED_TS > (
    SELECT COALESCE(MAX(UPDATED_TS), '{{ var('default_date') }}')
    FROM {{ ref('fact_taxi_trips') }}
    )
{% endif %}
