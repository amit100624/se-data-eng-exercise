SELECT
    {{ dbt_utils.generate_surrogate_key(['VENDOR_ID']) }} AS VENDOR_ID,
    CASE
        WHEN VENDOR_ID = '1' THEN 'Creative Mobile Technologies, LLC'
        WHEN VENDOR_ID = '2' THEN 'VeriFone Inc'
        ELSE 'N/A'
    END AS VENDOR_NAME,
    CREATED_TIMESTAMP AS UPDATED_TS
FROM {{ ref('taxi_trips_consistent') }}
{% if is_incremental() %}
WHERE UPDATED_TS > (
    SELECT COALESCE(MAX(UPDATED_TS), '{{ var('default_date') }}')
    FROM {{ this }}
)
{% endif %}
