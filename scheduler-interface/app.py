from flask import Flask, request, jsonify
from kafka import KafkaProducer
import json

app = Flask(__name__)
producer = KafkaProducer(bootstrap_servers='localhost:9092', value_serializer=lambda v: json.dumps(v).encode('utf-8'))

@app.route('/schedule', methods=['POST'])
def schedule_task():
    task = request.json
    producer.send('tasks', task)
    return jsonify({'status': 'Task scheduled'}), 200

if __name__ == '__main__':
    app.run(port=5000)
