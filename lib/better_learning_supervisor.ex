defmodule BL.Supervisor do
  use Supervisor

  @exercise_sup_name BL.Monitor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    IO.puts "Starting main supervisor"
    children = [
      worker(@exercise_sup_name, [@exercise_sup_name, :ok])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

