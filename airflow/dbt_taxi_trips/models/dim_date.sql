{{
    config(
        materialized = 'incremental',
        unique_key = ['DATE_ID']
    )
}}

WITH TAXI_TRIPS_DATES AS (
    SELECT
        DATE(TPEP_PICKUP_DATETIME)::TIMESTAMP_NTZ AS DATE,
        CREATED_TIMESTAMP AS UPDATED_TS
    FROM {{ ref('taxi_trips_consistent') }}
    UNION
    SELECT
        DATE(TPEP_DROPOFF_DATETIME)::TIMESTAMP_NTZ AS DATE,
        CREATED_TIMESTAMP AS UPDATED_TS
    FROM {{ ref('taxi_trips_consistent') }}
),

TAXI_TRIPS_DATES_WITH_KEYS AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['DATE']) }} AS DATE_ID,
        DATE,
        UPDATED_TS
    FROM TAXI_TRIPS_DATES
)

SELECT
    DATE_ID,
    YEAR(DATE)::NUMBER(4,0) AS YEAR,
    MONTH(DATE)::NUMBER(2,0) AS MONTH,
    WEEK(DATE)::NUMBER(2,0) AS WEEK_OF_THE_YEAR,
    DATE,
    UPDATED_TS
FROM (
    {{ dbt_utils.deduplicate(
       relation = 'TAXI_TRIPS_DATES_WITH_KEYS',
       partition_by = 'DATE_ID',
       order_by = 'UPDATED_TS DESC'
       )
    }})
{% if is_incremental() %}
WHERE UPDATED_TS > (
    SELECT COALESCE(MAX(UPDATED_TS), '{{ var('default_date') }}')
    FROM {{ this }}
)
{% endif %}
