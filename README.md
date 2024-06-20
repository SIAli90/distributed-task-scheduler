# Distributed Task Scheduler

This project demonstrates a distributed task scheduler using Rust, Python, and Elixir with Kafka for event-driven communication.

## Project Structure

- **core-engine (Rust)**: Handles the core task execution logic.
- **scheduler-interface (Python)**: Provides a REST API to schedule tasks.
- **distributed-communication (Elixir)**: Manages distributed task execution and communication.

## Setup

### Prerequisites

- Rust
- Python 3
- Elixir
- Docker

### Kafka Setup

```bash
docker run -d --name zookeeper -p 2181:2181 zookeeper
docker run -d --name kafka -p 9092:9092 --link zookeeper wurstmeister/kafka
docker exec kafka kafka-topics.sh --create --topic tasks --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1
```

### Running the Core Engine

```bash
cd core-engine
cargo run
```

### Running the Scheduler Interface

```bash
cd scheduler-interface
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

### Running the Distributed Communication

```bash
cd distributed-communication
mix deps.get
iex -S mix
```

## Usage

1. Start the Core Engine.
2. Start the Scheduler Interface.
3. Start the Distributed Communication.
4. Schedule tasks using the Scheduler Interface.

```bash
curl -X POST -H "Content-Type: application/json" -d '{"task": "example"}' http://localhost:5000/schedule
```
