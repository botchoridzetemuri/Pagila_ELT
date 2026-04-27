import logging
from airflow.decorators import dag, task
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from datetime import datetime

logger = logging.getLogger(__name__)

@dag(
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    tags=['verification', 'snowflake']
)
def snowflake_verification_dag():

    @task
    def verify_replication():
        logger.info("Starting Snowflake data verification...")
        
        try:
            hook = SnowflakeHook(snowflake_conn_id='snowflake_default')

            pagila_count = hook.get_records("SELECT COUNT(*) FROM TASK11.PAGILA_RAWS.ACTOR;")[0][0]
            sakila_count = hook.get_records("SELECT COUNT(*) FROM TASK11.SAKILA_RAWS.FILM;")[0][0]
            
            logger.info("REPLICATION VERIFICATION SUCCESSFUL")
            logger.info(f"Pagila ACTOR table row count: {pagila_count}")
            logger.info(f"Sakila FILM table row count: {sakila_count}")
            
        except Exception as e:
            logger.error("Verification failed. Check Snowflake connection and permissions.")
            logger.error(f"Error details: {str(e)}")
            raise e 

    verify_replication()

snowflake_verification_dag()