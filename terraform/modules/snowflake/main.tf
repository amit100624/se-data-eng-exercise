resource "snowflake_table" "taxi_trips_curated" {
  name     = "TAXI_TRIPS_CURATED"
  database = var.database
  schema   = var.schema

  column {
    name = "VENDOR_NAME"
    type = "STRING"
  }

  column {
    name = "TPEP_PICKUP_DATETIME"
    type = "STRING"
  }

  column {
    name = "TPEP_DROPOFF_DATETIME"
    type = "STRING"
  }

  column {
    name = "PASSENGER_COUNT"
    type = "STRING"
  }

  column {
    name = "TRIP_DISTANCE"
    type = "STRING"
  }

  column {
    name = "PICKUP_LONGITUDE"
    type = "STRING"
  }

  column {
    name = "PICKUP_LATITUDE"
    type = "STRING"
  }

  column {
    name = "RATECODE_ID"
    type = "STRING"
  }

  column {
    name = "STORE_AND_FWD_FLAG"
    type = "STRING"
  }

  column {
    name = "DROPOFF_LONGITUDE"
    type = "STRING"
  }

  column {
    name = "DROPOFF_LATITUDE"
    type = "STRING"
  }

  column {
    name = "PAYMENT_TYPE"
    type = "STRING"
  }

  column {
    name = "PAYMENT_TYPE_NAME"
    type = "STRING"
  }

  column {
    name = "FARE_AMOUNT"
    type = "STRING"
  }

  column {
    name = "EXTRA"
    type = "STRING"
  }

  column {
    name = "MTA_TAX"
    type = "STRING"
  }

  column {
    name = "TIP_AMOUNT"
    type = "STRING"
  }

  column {
    name = "TOLLS_AMOUNT"
    type = "STRING"
  }

  column {
    name = "IMPROVEMENT_SURCHARGE"
    type = "STRING"
  }

  column {
    name = "TOTAL_AMOUNT"
    type = "STRING"
  }

  column {
    name = "TRIP_DURATION_MINUTES"
    type = "STRING"
  }

  column {
    name = "TRIP_SPEED_MPH"
    type = "STRING"
  }

  column {
    name = "CREATED_TIMESTAMP"
    type = "TIMESTAMP_NTZ"
    default {
      expression = "CURRENT_TIMESTAMP()"
    }
  }
}