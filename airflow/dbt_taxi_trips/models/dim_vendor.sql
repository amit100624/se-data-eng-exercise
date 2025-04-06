SELECT
    {{ dbt_utils.generate_surrogate_key(['VENDOR_ID']) }} AS VENDOR_ID,
    CASE
        WHEN VENDOR_ID = '1' THEN 'Creative Mobile Technologies, LLC'
        WHEN VENDOR_ID = '2' THEN 'VeriFone Inc'
        ELSE 'N/A'
    END AS VENDOR_NAME
FROM {{ ref('taxi_trips_consistent') }}
