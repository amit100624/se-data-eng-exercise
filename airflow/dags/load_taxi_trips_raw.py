from __future__ import annotations
import json
import pendulum
from airflow.decorators import dag, task, task_group
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
import os

#CONSTANTS
RAW_TABLE_NAME = "TAXI_TRIPS_RAW"
DBT_HOME = "/usr/local/airflow/dbt"
DBT_TAXI_TRIPS_PROJECT = "/usr/local/airflow/dbt/taxi_trips"
STG_CONSISTENT_TABLE_NAME = "STG_TAXI_TRIPS_CONSISTENT"

@dag(
    schedule=None,
    start_date=pendulum.datetime(2024, 12, 10, tz="UTC"),
    catchup=False,
    tags=["snowflake", "gcs"],
)
def load_and_transform_taxi_trips_raw():

  # [START extract]

  @task
  def extract():
      print("Extracting...")
      return True

  # [END extract]

  # [START load]

  @task
  def load():
    hook = SnowflakeHook(snowflake_conn_id="snowflake_default")
    stage_name = "TAXI_TRIPS_RAW_STAGE"

    query = f"""
      COPY INTO {RAW_TABLE_NAME}
      FROM @{stage_name}
      FILE_FORMAT = (FORMAT_NAME = 'CSV_FILE_FORMAT')
      PATTERN = '.*taxi_trips_\\\\d{{8}}.*.csv';
    """

    print(f"Loading CSV data from {stage_name}...")
    hook.run(sql=query)
    print(f"Successfully loaded CSV data into {RAW_TABLE_NAME}")
    return True

  # [END load]

  # [START transform]

  @task_group
  def transform():
    @task.bash
    def install_dbt():
      activate_env = f"cd {DBT_HOME} && source dbt_env/bin/activate"
      install_dbt = f"pip install dbt-core dbt-snowflake && dbt --version"
      print(f"Installing dbt...")
      return f"{activate_env} && {install_dbt}"

    @task.bash
    def exec_dbt() -> str:
      print(f"Transforming raw data from {RAW_TABLE_NAME}...")
      execute_dbt_test = f"cd {DBT_TAXI_TRIPS_PROJECT} && dbt test --select 'stg_taxi_trips_consistent,test_type:data'"
      execute_dbt_run = f"cd {DBT_TAXI_TRIPS_PROJECT} && dbt run --select stg_taxi_trips_consistent"
      return f"{execute_dbt_test} && {execute_dbt_run}"

    @task
    def post_exec_dbt():
      print(f"Transformed raw data and successfully loaded into {STG_CONSISTENT_TABLE_NAME}")

    install_dbt() >> exec_dbt() >> post_exec_dbt()

  # [END transform]

  # [START main_flow]

  extract() >> load() >> transform()

  # [END main_flow]

# [START dag_invocation]

load_and_transform_taxi_trips_raw()

# [END dag_invocation]
