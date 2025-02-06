from __future__ import annotations
import json
import pendulum
from airflow.decorators import dag, task
from airflow.providers.google.cloud.hooks.gcs import GCSHook

# [START instantiate_dag]

@dag(

    schedule=None,

    start_date=pendulum.datetime(2024, 12, 10, tz="UTC"),

    catchup=False,

    tags=["gcs,example"],

)

# [END instantiate_dag]

def test_taskflow_api_dag():

    # [START extract]

    @task()
    def extract():

        content = 'Hello world'

        return content


    # [END extract]


    # [START transform]

    @task()
    def transform(content: str):

        transformed = f"{content}!"


        return transformed


    # [END transform]


    # [START load]

    @task()
    def load(transformed: str):
        print(f"The transformed data is: {transformed}")
        
        hook = GCSHook(gcp_conn_id="google_cloud_default")
        bucket_name = "se-data-landing-amit"
        object_name = "hello_world.txt"
        
        #Upload hello_world.txt into the bucket
        hook.upload(bucket_name=bucket_name, object_name=object_name, data=transformed)
        print(f"The hello_world.txt file has been successfully uploaded to the bucket: {bucket_name}")
        
        #Download hello_world.txt and display its content
        object_content = hook.download(bucket_name=bucket_name, object_name=object_name)
        print(f"File: {object_name}, content: {object_content}")
        
        # List all the files in the bucket
        objects = hook.list(bucket_name=bucket_name)
        print(f"The list of bucket objects: {objects}")


    # [END load]


    # [START main_flow]

    content = extract()

    transformed = transform(content)

    load(transformed)

    # [END main_flow]



# [START dag_invocation]

test_taskflow_api_dag()

# [END dag_invocation]
