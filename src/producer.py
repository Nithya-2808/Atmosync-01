from kafka import KafkaProducer
import json, random, time

producer = KafkaProducer(
    bootstrap_servers='localhost:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

reading = {
    "container_id": f"CTR-{random.randint(1000,1099)}",
    "temperature_c": round(random.uniform(-5, 15), 2),
    "humidity_pct": round(random.uniform(30, 95), 2),
    "vibration": round(random.uniform(0, 2), 3),
    "timestamp": time.time()
}
print(reading)
producer.send('container-telemetry', reading)
producer.flush()
print("Sent one message successfully.")