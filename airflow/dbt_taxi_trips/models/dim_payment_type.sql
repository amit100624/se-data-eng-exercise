SELECT
    {{ dbt_utils.generate_surrogate_key(['PAYMENT_TYPE']) }} AS PAYMENT_TYPE_ID,
    CASE
        WHEN PAYMENT_TYPE = '1' THEN 'Credit card'
        WHEN PAYMENT_TYPE = '2' THEN 'Cash'
        WHEN PAYMENT_TYPE = '3' THEN 'No charge'
        WHEN PAYMENT_TYPE = '4' THEN 'Dispute'
        WHEN PAYMENT_TYPE = '5' THEN 'Unknown'
        WHEN PAYMENT_TYPE = '6' THEN 'Voided trip'
        ELSE 'N/A'
    END AS PAYMENT_TYPE_NAME,
    CREATED_TIMESTAMP AS UPDATED_TS
FROM {{ ref('taxi_trips_consistent') }}
{% if is_incremental() %}
WHERE UPDATED_TS > (
    SELECT COALESCE(MAX(UPDATED_TS), '{{ var('default_date') }}')
    FROM {{ this }}
)
{% endif %}
