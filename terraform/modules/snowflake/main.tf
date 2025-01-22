resource "snowflake_table" "taxi_trips_raw" {
  name     = "taxi_trips_raw"
  database = var.database
  schema   = var.schema

  column {
    name = "vendor_name"
    type = "STRING"
  }

  column {
    name = "tpep_pickup_datetime"
    type = "STRING"
  }

  column {
    name = "tpep_dropoff_datetime"
    type = "STRING"
  }

  column {
    name = "passenger_count"
    type = "STRING"
  }

  column {
    name = "trip_distance"
    type = "STRING"
  }

  column {
    name = "pickup_longitude"
    type = "STRING"
  }

  column {
    name = "pickup_latitude"
    type = "STRING"
  }

  column {
    name = "ratecode_id"
    type = "STRING"
  }

  column {
    name = "store_and_fwd_flag"
    type = "STRING"
  }

  column {
    name = "dropoff_longitude"
    type = "STRING"
  }

  column {
    name = "dropoff_latitude"
    type = "STRING"
  }

  column {
    name = "payment_type"
    type = "STRING"
  }

  column {
    name = "payment_type_name"
    type = "STRING"
  }

  column {
    name = "fare_amount"
    type = "STRING"
  }

  column {
    name = "extra"
    type = "STRING"
  }

  column {
    name = "mta_tax"
    type = "STRING"
  }

  column {
    name = "tip_amount"
    type = "STRING"
  }

  column {
    name = "tolls_amount"
    type = "STRING"
  }

  column {
    name = "improvement_surcharge"
    type = "STRING"
  }

  column {
    name = "total_amount"
    type = "STRING"
  }

  column {
    name = "trip_duration_minutes"
    type = "STRING"
  }

  column {
    name = "trip_speed_mph"
    type = "STRING"
  }

  column {
    name = "created_timestamp"
    type = "TIMESTAMP_NTZ"
    default {
      expression = "CURRENT_TIMESTAMP()"
    }
  }
}
