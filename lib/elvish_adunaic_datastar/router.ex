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

  # ============================================
  # MISSION CONTROL PAGES
  # Each page showcases different Elvish primitives
  # ============================================

  # Dashboard: i-vircantie, i-gwistindor, i-hath, i-tiniath
  get "/sample-1" do
    html = ElvishAdunaicDatastar.MissionControl.Dashboard.render()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # Crew: i-vircantie for crew cards, i-bau for profiles
  get "/sample-1/crew" do
    html = ElvishAdunaicDatastar.MissionControl.Crew.render()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # Systems: i-miriant explicit grid, i-hath status lists
  get "/sample-1/systems" do
    html = ElvishAdunaicDatastar.MissionControl.Systems.render()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # Sensors: i-glan-tholl reel, i-gant-thala aspect ratio
  get "/sample-1/sensors" do
    html = ElvishAdunaicDatastar.MissionControl.Sensors.render()

    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, html)
  end

  # Comms: i-esgal cover, i-glan-veleg nested sidebar
  get "/sample-1/comms" do
    html = ElvishAdunaicDatastar.MissionControl.Comms.render()

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
    <div id="activity-log"><i-hath space="0" style="--hath-space: 0;"><div class="log-entry" style="color: var(--color-accent);"><div class="log-time">#{time_str}</div><div>Manual log entry added via SSE</div></div><div class="log-entry"><div class="log-time">07:42</div><div>Sensor array calibration complete</div></div><div class="log-entry"><div class="log-time">07:15</div><div>Shift change: Alpha crew on duty</div></div><div class="log-entry"><div class="log-time">06:58</div><div>Communications relay synchronized</div></div></i-hath></div>
    """

    event = """
    event: datastar-patch-elements
    data: elements #{String.trim(log_html)}

    """

    conn
    |> put_resp_content_type("text/event-stream")
    |> put_resp_header("cache-control", "no-cache")
    |> send_chunked(200)
    |> send_sse_event(event)
  end

  # SSE endpoint: Send message in Comms page
  post "/sse/send-message" do
    # For POST requests, Datastar sends signals as JSON body
    {:ok, body, conn} = Plug.Conn.read_body(conn)
    signals = case Jason.decode(body) do
      {:ok, parsed} -> parsed
      {:error, _} -> %{}
    end

    message_text = Map.get(signals, "messageText", "")
    channel = Map.get(signals, "activeChannel", "bridge")

    now = DateTime.utc_now()
    time_str = Calendar.strftime(now, "%H:%M")

    # Only process if there's a message
    if message_text != "" do
      # Create the outgoing message HTML
      outgoing_msg = """
      <div class="message outgoing">
        <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
          <div style="font-size: 0.8rem; opacity: 0.7;">You • #{time_str}</div>
          <div>#{html_escape(message_text)}</div>
        </i-hath>
      </div>
      """

      # Generate a contextual reply based on channel
      reply = generate_reply(channel, message_text)
      reply_msg = """
      <div class="message incoming">
        <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
          <div style="font-size: 0.8rem; color: var(--color-text-muted);">#{reply.sender} • #{time_str}</div>
          <div>#{reply.text}</div>
        </i-hath>
      </div>
      """

      # Patch the new messages into the container
      event = """
      event: datastar-patch-elements
      data: selector #new-messages
      data: mode append
      data: elements <div>#{String.replace(outgoing_msg, "\n", "")}#{String.replace(reply_msg, "\n", "")}</div>

      event: datastar-patch-signals
      data: signals {messageText: ''}

      """

      conn
      |> put_resp_content_type("text/event-stream")
      |> put_resp_header("cache-control", "no-cache")
      |> send_chunked(200)
      |> send_sse_event(event)
    else
      conn
      |> put_resp_content_type("text/event-stream")
      |> put_resp_header("cache-control", "no-cache")
      |> send_chunked(200)
      |> send_sse_event("")
    end
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

  # HTML escape for user input
  defp html_escape(text) do
    text
    |> String.replace("&", "&amp;")
    |> String.replace("<", "&lt;")
    |> String.replace(">", "&gt;")
    |> String.replace("\"", "&quot;")
    |> String.replace("'", "&#39;")
  end

  # Generate contextual replies based on channel
  defp generate_reply(channel, _message) do
    case channel do
      "bridge" ->
        Enum.random([
          %{sender: "Cmdr. Kowalski", text: "Acknowledged. Keep me posted on any changes."},
          %{sender: "Lt. Nakamura", text: "Copy that. I'll coordinate with Engineering."},
          %{sender: "Ens. Rodriguez", text: "Understood. Standing by for further instructions."}
        ])
      "engineering" ->
        Enum.random([
          %{sender: "Lt. Nakamura", text: "Roger that. I'll check the diagnostics and report back."},
          %{sender: "Ens. Wong", text: "On it. Should have an update within the hour."},
          %{sender: "Lt. Nakamura", text: "Affirmative. Power systems are stable for now."}
        ])
      "science" ->
        Enum.random([
          %{sender: "Ens. Rodriguez", text: "Fascinating! I'll add that to my analysis. 🔬"},
          %{sender: "Ens. Rodriguez", text: "Good thinking. Let me run some additional tests."},
          %{sender: "Ens. Rodriguez", text: "Noted. The data supports your observation."}
        ])
      "medical" ->
        Enum.random([
          %{sender: "Dr. Kane", text: "Thanks for the update. Stay healthy out there! 💊"},
          %{sender: "Dr. Kane", text: "Understood. I'll make a note in your file."},
          %{sender: "Dr. Kane", text: "Roger. Don't forget to stay hydrated!"}
        ])
      "kowalski" ->
        Enum.random([
          %{sender: "Cmdr. Kowalski", text: "Good work. I appreciate the update."},
          %{sender: "Cmdr. Kowalski", text: "Acknowledged. Keep up the excellent work! 🌟"},
          %{sender: "Cmdr. Kowalski", text: "Thank you. I'll factor that into our planning."}
        ])
      "earth" ->
        Enum.random([
          %{sender: "Earth Command", text: "Message received, Station Anarion. Stand by for confirmation. 🌍"},
          %{sender: "Earth Command", text: "Copy that. Earth Command acknowledges your transmission."},
          %{sender: "Earth Command", text: "Understood. We'll relay this to mission control."}
        ])
      _ ->
        %{sender: "System", text: "Message received."}
    end
  end
end
