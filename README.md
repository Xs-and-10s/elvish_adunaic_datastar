# Elvish + Adûnaic + Datastar Testbed

A minimal Elixir application for testing the integration of:

- **[Elvish CSS](https://www.npmjs.com/package/elvish-css)** — Layout primitives (Stack, Center, Cluster, etc.)
- **[Adûnaic](https://www.npmjs.com/package/adunaic)** — Shadow DOM UI components
- **[Datastar](https://data-star.dev/)** — Reactive hypermedia via Server-Sent Events

## Quick Start

```bash
# Install Elixir dependencies
mix setup

# Or manually:
mix deps.get
npm install

# Start the server
mix run --no-halt

# Or use iex for interactive development
iex -S mix
```

Then open [http://localhost:1571](http://localhost:1571)

## Project Structure

```
elvish_adunaic_datastar/
├── config/
│   └── config.exs           # Elixir configuration (MIME types for SSE)
├── lib/
│   └── elvish_adunaic_datastar/
│       ├── application.ex   # OTP Application (starts Bandit server)
│       ├── router.ex        # Plug Router (routes + SSE endpoints)
│       └── pages.ex         # HTML templates
├── priv/
│   └── static/
│       └── css/
│           └── app.css      # Custom styles
├── mix.exs                  # Elixir project config
├── package.json             # npm dependencies
└── README.md
```

## Dependencies

### Elixir (Hex.pm)

| Package | Purpose |
|---------|---------|
| `bandit` | HTTP server |
| `plug` | HTTP middleware |
| `datastar_ex` | Datastar SSE helpers |
| `jason` | JSON encoding |

### JavaScript (npm/CDN)

| Package | Purpose |
|---------|---------|
| `elvish-css` | Layout primitives |
| `adunaic` | Shadow DOM components |
| `datastar` | Client-side reactivity (via CDN) |

## How It Works

1. **Bandit** serves HTTP on port 1571
2. **Plug.Router** handles routes:
   - `GET /` — Main HTML page
   - `GET /sse` — SSE endpoint for Datastar
   - `GET /sse/:action` — Action-specific SSE endpoints
3. **Datastar** on the client listens for SSE events and updates the DOM
4. **Elvish CSS** provides layout primitives (`el-stack`, `el-center`, `el-cluster`)
5. **Adûnaic** provides styled components (`an-tabar`, `an-hazar`, `an-dawar`, etc.)

## Datastar Integration

### Client-side Attributes

```html
<!-- GET request on click -->
<an-tabar data-on-click="$$get('/sse/hello')">Click me</an-tabar>

<!-- Update signal directly -->
<an-tabar data-on-click="$greeting = 'Hello!'">Update</an-tabar>

<!-- Show signal value -->
<span data-text="$greeting"></span>
```

### Server-side SSE (with datastar_ex)

```elixir
# In your route handler
alias Datastar.{SSE, Fragments, Signals}

conn
|> SSE.new()
|> Fragments.merge("<span id='greeting'>Hello!</span>", selector: "#greeting")
|> Signals.patch(%{count: 42})
|> SSE.close()
```

## Elvish CSS Classes

| Class | Purpose |
|-------|---------|
| `el-stack` | Vertical stack with `--stack-gap` |
| `el-center` | Horizontally centered container |
| `el-cluster` | Flexible horizontal grouping |
| `el-sidebar` | Sidebar layout |
| `el-switcher` | Responsive row/column switcher |

## Adûnaic Components

| Component | Purpose |
|-----------|---------|
| `an-tabar` | Button |
| `an-hazar` | Alert banner |
| `an-dawar` | Loading spinner |
| `an-ganad` | Progress bar |
| `an-zal` | Toggle switch |
| `an-kuph` | Modal dialog |
| `an-liphim` | Tabs |
| `an-saril` | Slider |
| `an-saril-tad` | Range slider |
| `an-rash` | Toast notifications |
| `an-nazar-dak` | Focus trap |

## Development

### Adding new pages

Edit `lib/elvish_adunaic_datastar/pages.ex` and add new functions:

```elixir
def my_page do
  """
  <!DOCTYPE html>
  ...
  """
end
```

Then add a route in `router.ex`:

```elixir
get "/my-page" do
  html = ElvishAdunaicDatastar.Pages.my_page()
  conn |> put_resp_content_type("text/html") |> send_resp(200, html)
end
```

### Adding SSE actions

Add handlers in `router.ex`:

```elixir
defp handle_sse_action(conn, "my-action") do
  # Build SSE event
  event = "event: datastar-merge-fragments\\ndata: fragments <div>Updated!</div>\\n\\n"
  {:ok, conn} = chunk(conn, event)
  conn
end
```

## License

MIT
