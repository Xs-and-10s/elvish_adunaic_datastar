# Elvish + Adûnaic + Datastar Testbed

A minimal Elixir application for testing the integration of:

- **[Elvish CSS](https://www.npmjs.com/package/elvish-css)** — Layout primitives (Sindarin-named custom elements)
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
   - `GET /sse/greet` — SSE endpoint for greeting
   - `GET /sse/reset` — SSE endpoint to reset
   - `GET /sse/increment` — SSE endpoint for counter
3. **Datastar** on the client listens for SSE events and updates the DOM
4. **Elvish CSS** provides layout primitives (`<i-hath>`, `<i-enedh>`, `<i-tiniath>`)
5. **Adûnaic** provides styled components (`<an-tâbar>`, `<an-hâzar>`, `<an-dâwar>`, etc.)

## Datastar Integration

### Client-side Attributes (Datastar 1.0 Syntax)

```html
<!-- GET request on click (note: colon separator, @ prefix for actions) -->
<an-tabar data-on:click="@get('/sse/hello')">Click me</an-tabar>

<!-- Update signal directly ($ prefix for signals) -->
<an-tabar data-on:click="$greeting = 'Hello!'">Update</an-tabar>

<!-- Show signal value -->
<span data-text="$greeting"></span>

<!-- Initialize signals -->
<div data-signals="{count: 0, name: ''}">...</div>
```

### Server-side SSE Format (Datastar 1.0)

```elixir
# Patch elements (HTML fragments with IDs)
event = """
event: datastar-patch-elements
data: elements <span id="greeting">Hello!</span>

"""

# Patch signals (update reactive state)
event = """
event: datastar-patch-signals
data: signals {count: 42}

"""
```

## Elvish CSS Layout Primitives

| Sindarin | Layout | English | Meaning |
|----------|--------|---------|---------|
| Hath | `<i-hath>` | Stack | "row, series" |
| Bau | `<i-bau>` | Box | "container" |
| Enedh | `<i-enedh>` | Center | "middle" |
| Tiniath | `<i-tiniath>` | Cluster | "small sparks" |
| Glân Veleg | `<i-glan-veleg>` | Sidebar | "clear + mighty" |
| Gwistindor | `<i-gwistindor>` | Switcher | "change-watcher" |
| Esgal | `<i-esgal>` | Cover | "screen, hiding" |
| Vircantië | `<i-vircantie>` | Grid | "jewel-pattern" |
| Gant Thala | `<i-gant-thala>` | Frame | "harp-foot (ratio)" |
| Glân Tholl | `<i-glan-tholl>` | Reel | "open + hollow" |
| Fano | `<i-fano>` | Imposter | "white phantom" |
| Thann | `<i-thann>` | Icon | "sign, token" |
| Adleithian | `<i-adleithian>` | Container | "liberator" |
| Him | `<i-him>` | Sticky | "steadfast" |
| Miriant | `<i-miriant>` | Grid-placed | "jewel-work" |
| Gonath | `<i-gonath>` | Masonry | "stone collection" |
| Thîr | `<i-thir>` | Effects | "face, countenance" |
| Gil | `<i-gil>` | Link | "star, spark" |
| Têw | `<i-tew>` | Typography | "letters, writing" |

## Adûnaic UI Components

| Adûnaic | Component | English | Meaning |
|---------|-----------|---------|---------|
| Tâbar | `<an-tabar>` | Button | "striker, push" |
| Hâzar | `<an-hazar>` | Alert | "warning sign" |
| Dâwar | `<an-dawar>` | Spinner | "wheel, rotation" |
| Gânâd | `<an-ganad>` | Progress | "path, journey" |
| Zâl | `<an-zal>` | Switch | "turn, change" |
| Kûph | `<an-kuph>` | Dialog | "voice, speech" |
| Lîphim | `<an-liphim>` | Tabs | "leaves, pages" |
| Sâril | `<an-saril>` | Slider | "glide, slide" |
| Sâril Tâd | `<an-saril-tad>` | Range Slider | "double slide" |
| Râsh | `<an-rash>` | Toast | "flash, brief" |
| Nâzar Dâk | `<an-nazar-dak>` | Focus Trap | "watch-hold" |

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

### Adding SSE endpoints

Add handlers in `router.ex`:

```elixir
get "/sse/my-action" do
  fragment = ~s(<div id="target">Updated!</div>)
  
  event = """
  event: datastar-patch-elements
  data: elements #{fragment}

  """
  
  conn
  |> put_resp_content_type("text/event-stream")
  |> put_resp_header("cache-control", "no-cache")
  |> send_chunked(200)
  |> send_sse_event(event)
end
```

## License

MIT
