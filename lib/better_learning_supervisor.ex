defmodule BL.Supervisor do
  use Supervisor

  @exercise_sup_name BL.Monitor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    IO.puts "Starting main supervisor"
    cfun_exercise = fn(arg) -> BL.Exercise.start_link(arg) end
    cfun_monitor = fn(arg) -> BL.Monitor.start_link(:nil, cfun_exercise) end
    children = [
      worker(@exercise_sup_name, [@exercise_sup_name, cfun_monitor])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

