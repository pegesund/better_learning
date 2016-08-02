defmodule BL.Monitor do
  use GenServer
  
  def start_link(name) do
    IO.puts "Starting Exercise Monitor"
    GenServer.start_link(__MODULE__, :ok, [name: name])
  end


  # have a look at http://elixir-lang.org/getting-started/mix-otp/genserver.html at the bottom


  @doc """
  Looks up the exercise pid 

  Returns `{:ok, pid}` if exists, `:error` otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Ensures there is a exercise associated to the given `name` in `server`.
  """
  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  ## Server callbacks

  def init(:ok) do
    IO.puts "I am inside init.."
    names = %{}
    refs  = %{}
    {:ok, %{:names => names, :refs => refs}}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state.names, name), state}
  end

  def handle_cast({:create, name}, state) do
    if Map.has_key?(state.names, name) do
      {:noreply, state}
    else
      {:ok, pid} = BL.Exercise.start_link(:ok)
      ref = Process.monitor(pid)
      refs = Map.put(state.refs, ref, name)
      names = Map.put(state.names, name, pid)
      {:noreply, %{:names => names, :refs => refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, state) do
    {name, refs} = Map.pop(state.refs, ref)
    names = Map.delete(state.names, name)
    {:noreply,  %{:names => names, :refs => refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

end
