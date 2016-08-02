defmodule BL.Monitor do
  use GenServer
  
  def start_link(name, cfun) do
    if name == :nil do
      IO.puts "Starting Monitor without name"
      GenServer.start_link(__MODULE__, cfun)
    else
      IO.puts "Starting Monitor with name"
      GenServer.start_link(__MODULE__, cfun, [name: name])
    end
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

  def init(cfun) do
    IO.puts "I am inside init.."
    names = %{}
    refs  = %{}
    {:ok, %{:names => names, :refs => refs, :cfun => cfun}}
  end

  def handle_call({:lookup, name}, _from, state) do
    {:reply, Map.fetch(state.names, name), state}
  end

  def handle_cast({:create, name}, state) do
    if Map.has_key?(state.names, name) do
      {:noreply, state}
    else
      {:ok, pid} = state.cfun.(:ok)
      ref = Process.monitor(pid)
      refs = Map.put(state.refs, ref, name)
      names = Map.put(state.names, name, pid)
      {:noreply, %{state | :names => names, :refs => refs}}
    end
  end

  def handle_info({:DOWN, ref, :process, _pid, _reason}, state) do
    {name, refs} = Map.pop(state.refs, ref)
    names = Map.delete(state.names, name)
    {:noreply,  %{state | :names => names, :refs => refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

end
