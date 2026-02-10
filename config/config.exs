import Config

# Accept event-stream requests for Datastar SSE
config :mime, :types, %{
  "text/event-stream" => ["sse"]
}

# JSON encoder
config :elvish_adunaic_datastar,
  json_library: Jason
