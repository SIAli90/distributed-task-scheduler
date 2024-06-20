defmodule KafkaConsumer do
  use GenServer

  @brokers [{"localhost", 9092}]
  @topic "tasks"

  def start_link(_opts) do
    {:ok, _pid} = :brod.start_client(@brokers, :client, [])
    :brod.start_link_group_subscriber(:client, @topic, 0, self(), [])
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info({:brod_message, _client, _topic, _partition, _offset, _key, payload}, state) do
    task = :erlang.binary_to_term(payload)
    DistributedCommunication.schedule_task(task)
    {:noreply, state}
  end
end
