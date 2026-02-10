defmodule ElvishAdunaicDatastar.Application do
  @moduledoc """
  Application supervisor for the Elvish + Adûnaic + Datastar testbed.
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, plug: ElvishAdunaicDatastar.Router, port: 1571}
    ]

    opts = [strategy: :one_for_one, name: ElvishAdunaicDatastar.Supervisor]
    
    IO.puts("""
    
    🏛️  Elvish + Adûnaic + Datastar Testbed
    ═══════════════════════════════════════
    
    Server running at: http://localhost:1571
    
    Press Ctrl+C to stop.
    """)
    
    Supervisor.start_link(children, opts)
  end
end
