defmodule DistributedCommunication do
  use GenServer

  # Client API
  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def schedule_task(task) do
    GenServer.cast(__MODULE__, {:schedule_task, task})
  end

  # Server Callbacks
  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_cast({:schedule_task, task}, state) do
    IO.puts("Scheduling task: #{inspect(task)}")
    {:noreply, state}
  end
end
