defmodule BL.Supervisor do
  use Supervisor

  @exercise_sup_name BL.Monitor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    IO.puts "Starting main supervisor"
    cfun = fn(arg) -> BL.Exercise.start_link(arg) end
    children = [
      worker(@exercise_sup_name, [@exercise_sup_name, cfun])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

