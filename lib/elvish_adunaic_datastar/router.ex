defmodule ElvishAdunaicDatastar.Router do
  @moduledoc """
  Main router for the testbed application.

  Datastar 1.0 SSE Event Format:
  - datastar-patch-elements: patches HTML into the DOM (by element ID)
  - datastar-patch-signals: updates reactive signals
  """
  use Plug.Router

  plug Plug.Static,
    at: "/static",
    from: {:elvish_adunaic_datastar, "priv/static"}

  plug :match
  plug :dispatch

  # Main page
  get "/" do
    html = ElvishAdunaicDatastar.Pages.index()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # Sample page 1: Mission Control Dashboard
  get "/sample-1" do
    html = ElvishAdunaicDatastar.SamplePage1.render()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # SSE endpoint: Greet the Galaxy
  get "/sse/greet" do
    # Datastar 1.0 SSE format:
    # event: datastar-patch-elements
    # data: elements <html with id>
    fragment = ~s(<span id="greeting">Greetings from the Galaxy! 🌌</span>)

    event = """
    event: datastar-patch-elements
    data: elements #{fragment}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> put_resp_header("connection", "keep-alive")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Reset greeting
  get "/sse/reset" do
    fragment = ~s(<span id="greeting">Hello Galaxy!</span>)

    event = """
    event: datastar-patch-elements
    data: elements #{fragment}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> put_resp_header("connection", "keep-alive")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Increment counter
  # Datastar sends all signals with requests by default
  get "/sse/increment" do
    # Parse signals from the datastar query param (JSON encoded)
    signals = parse_datastar_signals(conn)
    count = Map.get(signals, "count", 0)
    new_count = count + 1

    # Datastar 1.0 SSE format for signals:
    # event: datastar-patch-signals
    # data: signals {key: value}
    event = """
    event: datastar-patch-signals
    data: signals {count: #{new_count}}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> put_resp_header("connection", "keep-alive")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Run diagnostic (for sample page)
  get "/sse/run-diagnostic" do
    # Simulate a diagnostic that updates system readings
    event = """
    event: datastar-patch-signals
    data: signals {oxygenLevel: 96, powerOutput: 92, hullIntegrity: 100, systemStatus: 'optimal'}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Refresh systems (for sample page)
  get "/sse/refresh-systems" do
    # Randomize readings slightly
    oxygen = 90 + :rand.uniform(8)
    power = 82 + :rand.uniform(12)

    event = """
    event: datastar-patch-signals
    data: signals {oxygenLevel: #{oxygen}, powerOutput: #{power}}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Emergency protocol (for sample page)
  get "/sse/emergency" do
    alert_html = ~s(<an-hazar variant="error" dismissible><span slot="title">⚠️ Emergency Protocol Activated</span>All crew report to stations immediately. This is not a drill.</an-hazar>)

    event = """
    event: datastar-patch-elements
    data: elements <div id="alerts-container">#{alert_html}</div>

    event: datastar-patch-signals
    data: signals {systemStatus: 'EMERGENCY'}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Add new log entry (for sample page)
  get "/sse/new-log" do
    now = DateTime.utc_now()
    time_str = Calendar.strftime(now, "%H:%M")

    log_html = """
    <div id="activity-log" class="el-stack" style="--stack-gap: 0;">
      <div class="log-entry" style="color: var(--color-accent);">
        <div class="log-time">#{time_str}</div>
        <div>Manual log entry added via SSE</div>
      </div>
      <div class="log-entry">
        <div class="log-time">07:42</div>
        <div>Sensor array calibration complete</div>
      </div>
      <div class="log-entry">
        <div class="log-time">07:15</div>
        <div>Shift change: Alpha crew on duty</div>
      </div>
      <div class="log-entry">
        <div class="log-time">06:58</div>
        <div>Communications relay synchronized</div>
      </div>
    </div>
    """

    event = """
    event: datastar-patch-elements
    data: elements #{String.replace(log_html, "\n", "")}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  match _ do
    send_resp(conn, 404, "Not found")
  end

  # Parse Datastar signals from the request
  # Datastar sends signals as a JSON-encoded 'datastar' query parameter
  defp parse_datastar_signals(conn) do
    conn = Plug.Conn.fetch_query_params(conn)

    case Map.get(conn.query_params, "datastar") do
      nil -> %{}
      json_string ->
        case Jason.decode(json_string) do
          {:ok, signals} -> signals
          {:error, _} -> %{}
        end
    end
  end

  defp send_sse_event(conn, event) do
    {:ok, conn} = chunk(conn, event)
    conn
  end
end
