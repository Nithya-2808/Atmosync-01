import os, json
from dotenv import load_dotenv
from kafka import KafkaConsumer
import snowflake.connector

load_dotenv()
conn = snowflake.connector.connect(
    account=os.getenv("SNOWFLAKE_ACCOUNT"),
    user=os.getenv("SNOWFLAKE_USER"),
    password=os.getenv("SNOWFLAKE_PASSWORD"),
    warehouse=os.getenv("SNOWFLAKE_WAREHOUSE"),
    database=os.getenv("SNOWFLAKE_DATABASE"),
    schema=os.getenv("SNOWFLAKE_SCHEMA"),
)
cursor = conn.cursor()

consumer = KafkaConsumer(
    'container-telemetry',
    bootstrap_servers='localhost:9092',
    value_deserializer=lambda v: json.loads(v.decode('utf-8'))
)

print("Listening...")
for message in consumer:
    data = message.value
    cursor.execute(
        "INSERT INTO CONTAINER_TELEMETRY_RAW (raw_data) SELECT PARSE_JSON(%s)",
        (json.dumps(data),)
    )
    print("Saved to Snowflake:", data)