# Better learning

An adaptive learning system for education.

Under development


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `better_learning` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:better_learning, "~> 0.1.0"}]
    end
    ```

  2. Ensure `better_learning` is started before your application:

    ```elixir
    def application do
      [applications: [:better_learning]]
    end
    ```
    
    
    spacemacs:
    
    space - f -t (tree mode)
      tree up (K)
      tree set root (H)
      
    space - w - c  (close window)
    sapce - b - b (show buffers)
    
    Use like this:
    
    BL.Supervisor.start_link
    BL.Monitor.create(BL.Monitor, "HUPP")
    BL.Monitor.lookup(BL.Monitor, "HUPP")
