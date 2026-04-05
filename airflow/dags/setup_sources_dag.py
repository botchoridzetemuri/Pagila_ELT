from airflow.decorators import dag, task
from airflow.providers.postgres.hooks.postgres import PostgresHook
from datetime import datetime
import os

@dag(
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    tags=['infrastructure', 'sources-setup']
)
def setup_sources_dag():

    @task
    def run_database_setup(conn_id: str, db_folder: str, sql_files: list):

        hook = PostgresHook(postgres_conn_id=conn_id)
        base_path = f"/opt/airflow/dags/sql/{db_folder}"

        role_sql = """
        DO $$ BEGIN
            IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'postgres') THEN
                CREATE ROLE postgres WITH LOGIN PASSWORD 'postgres' SUPERUSER;
            END IF;
        END $$;
        """
        hook.run(role_sql)
        print(f"Role check complete for {conn_id}")

        hook.run("DROP SCHEMA public CASCADE; CREATE SCHEMA public;")
        print(f"Schema 'public' reset on {conn_id}")

        for file_name in sql_files:
            file_path = f"{base_path}/{file_name}"
            with open(file_path, 'r') as f:
                hook.run(f.read())
            print(f"Successfully executed: {file_path}")

    run_database_setup.override(task_id='setup_pagila')(
        conn_id='postgres_pagila', 
        db_folder='pagila',
        sql_files=['pagila-schema.sql', 'pagila-insert-data.sql']
    )

    run_database_setup.override(task_id='setup_sakila')(
        conn_id='postgres_sakila', 
        db_folder='sakila',
        sql_files=['sakila-schema.sql', 'sakila-insert-data.sql'] 
    )

setup_sources_dag()