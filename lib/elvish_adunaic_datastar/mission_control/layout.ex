defmodule ElvishAdunaicDatastar.MissionControl.Layout do
  @moduledoc """
  Shared layout for Mission Control pages.
  
  Provides:
  - HTML head with styles and scripts
  - Sidebar navigation with active state
  - Wrapper for main content
  
  Elvish primitives used:
  - <i-glan-veleg> — Sidebar layout (the main structural primitive)
  - <i-hath> — Vertical stacks
  - <i-tiniath> — Horizontal clusters  
  - <i-bau> — Box containers
  """

  @nav_items [
    %{id: "dashboard", label: "Dashboard", icon: "📊", path: "/sample-1"},
    %{id: "crew", label: "Crew", icon: "👥", path: "/sample-1/crew"},
    %{id: "systems", label: "Systems", icon: "⚡", path: "/sample-1/systems"},
    %{id: "sensors", label: "Sensors", icon: "📡", path: "/sample-1/sensors"},
    %{id: "comms", label: "Comms", icon: "📢", path: "/sample-1/comms"}
  ]

  @doc """
  Renders a complete page with the Mission Control layout.
  
  ## Parameters
  - active_page: atom matching one of the nav item ids (:dashboard, :crew, etc.)
  - page_title: string for the browser title
  - primitives_used: list of strings describing Elvish primitives featured
  - content: HTML string for the main content area
  """
  def render(active_page, page_title, primitives_used, content) do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>#{page_title} — Mission Control</title>
      
      <!-- Elvish CSS v2.3.0 -->
      <link rel="stylesheet" href="https://unpkg.com/elvish-css@2.3.0/dist/elvish.min.css">
      <script src="https://unpkg.com/elvish-css@2.3.0/dist/elvish.iife.js"></script>
      
      <!-- Adûnaic Components -->
      <script src="https://unpkg.com/adunaic@1.3.3/dist/adunaic.iife.js"></script>
      
      <!-- Datastar 1.0 -->
      <script type="module" src="https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-RC.7/bundles/datastar.js"></script>
      
      #{styles()}
    </head>
    <body>
      <!-- MAIN LAYOUT: Sidebar + Content using i-glan-veleg -->
      <i-glan-veleg side="left" side-width="240px" content-min="60%" space="0" style="--glan-veleg-width: 240px; --glan-veleg-content-min: 60%; --glan-veleg-space: 0;">
        
        #{sidebar(active_page)}
        
        <!-- MAIN CONTENT -->
        <main>
          <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);">
            <i-enedh max="1200px" gutters="0" style="--enedh-max: 1200px; --enedh-gutters: 0;">
              <i-hath space="var(--s1)" style="--hath-space: var(--s1);">
                
                <!-- Page Header with Primitives Badge -->
                <header>
                  <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
                    <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                      <h1>#{page_title}</h1>
                      <div class="primitives-badge">
                        #{primitives_badge(primitives_used)}
                      </div>
                    </i-hath>
                    <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
                      <div class="status-indicator">
                        <span class="status-dot"></span>
                        <span>Online</span>
                      </div>
                    </i-tiniath>
                  </i-tiniath>
                </header>
                
                <!-- Page Content -->
                #{content}
                
                #{footer()}
                
              </i-hath>
            </i-enedh>
          </i-bau>
        </main>
        
      </i-glan-veleg>
    </body>
    </html>
    """
  end

  defp sidebar(active_page) do
    nav_html = @nav_items
    |> Enum.map(fn item ->
      active_class = if to_string(active_page) == item.id, do: " active", else: ""
      """
      <a href="#{item.path}" class="nav-item#{active_class}">
        <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
          <span style="font-size: 1.1rem;">#{item.icon}</span>
          <span>#{item.label}</span>
        </i-tiniath>
      </a>
      """
    end)
    |> Enum.join("\n")

    """
    <aside class="sidebar">
      <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);">
        <i-hath space="var(--s1)" style="--hath-space: var(--s1);">
          
          <!-- Logo -->
          <i-tiniath space="var(--s-1)" justify="start" align="center" style="--tiniath-space: var(--s-1); --tiniath-justify: start; --tiniath-align: center;">
            <span style="font-size: 1.5rem;">🛸</span>
            <i-hath space="0" style="--hath-space: 0;">
              <div style="font-weight: 600;">Station Anarion</div>
              <div style="font-size: 0.75rem; color: var(--color-text-muted);">Mission Control</div>
            </i-hath>
          </i-tiniath>
          
          <!-- Navigation -->
          <nav>
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              #{nav_html}
            </i-hath>
          </nav>
          
          <!-- Status Footer -->
          <div style="margin-top: auto; padding-top: var(--s1); border-top: 1px solid rgba(255,255,255,0.1);">
            <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
              <span class="status-dot"></span>
              <span style="font-size: 0.85rem;">All Systems</span>
              <span style="color: var(--color-success); font-size: 0.85rem; font-weight: 500;">optimal</span>
            </i-tiniath>
          </div>
          
        </i-hath>
      </i-bau>
    </aside>
    """
  end

  defp primitives_badge(primitives) do
    primitives
    |> Enum.map(fn p -> "<span class=\"primitive-tag\">#{p}</span>" end)
    |> Enum.join("")
  end

  defp footer do
    """
    <footer style="margin-top: var(--s2);">
      <i-enedh style="--enedh-max: 100%;">
        <i-tiniath space="var(--s1)" justify="center" align="center" style="--tiniath-space: var(--s1); --tiniath-justify: center; --tiniath-align: center; opacity: 0.5; font-size: 0.85rem; padding-top: var(--s0); border-top: 1px solid rgba(255,255,255,0.1);">
          <span>Elvish CSS</span>
          <span>•</span>
          <span>Adûnaic Components</span>
          <span>•</span>
          <span>Datastar SSE</span>
          <span>•</span>
          <a href="/" style="color: var(--color-accent);">← Back to Testbed</a>
        </i-tiniath>
      </i-enedh>
    </footer>
    """
  end

  defp styles do
    """
    <style>
      :root {
        --color-bg: #0a0a0f;
        --color-surface: #13131a;
        --color-surface-raised: #1a1a24;
        --color-text: #e5e5e5;
        --color-text-muted: #888;
        --color-accent: oklch(75% 0.18 168);
        --color-warning: oklch(75% 0.15 85);
        --color-danger: oklch(65% 0.2 25);
        --color-success: oklch(70% 0.17 145);
        
        /* Elvish spacing scale */
        --s-2: 0.25rem;
        --s-1: 0.5rem;
        --s0: 1rem;
        --s1: 1.5rem;
        --s2: 2rem;
        --s3: 3rem;
      }
      
      *, *::before, *::after { box-sizing: border-box; }
      
      body {
        font-family: system-ui, -apple-system, sans-serif;
        background: var(--color-bg);
        color: var(--color-text);
        margin: 0;
        min-height: 100vh;
        line-height: 1.5;
      }
      
      h1, h2, h3 { margin: 0; font-weight: 600; }
      h1 { font-size: 1.75rem; }
      h2 { font-size: 1.25rem; color: var(--color-accent); }
      h3 { font-size: 1rem; opacity: 0.9; }
      
      /* Panel styling */
      .panel {
        background: var(--color-surface);
        border-radius: 12px;
      }
      
      .panel-header {
        padding-bottom: 0.75rem;
        border-bottom: 1px solid rgba(255,255,255,0.1);
        margin-bottom: 0.75rem;
      }
      
      /* Status indicators */
      .status-dot {
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: var(--color-success);
        animation: pulse 2s ease-in-out infinite;
      }
      
      .status-indicator {
        display: flex;
        align-items: center;
        gap: 0.5rem;
        font-size: 0.85rem;
        color: var(--color-text-muted);
      }
      
      @keyframes pulse {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
      }
      
      /* Primitives badge */
      .primitives-badge {
        display: flex;
        flex-wrap: wrap;
        gap: 0.25rem;
      }
      
      .primitive-tag {
        display: inline-block;
        padding: 0.15rem 0.5rem;
        background: rgba(255,255,255,0.1);
        border-radius: 4px;
        font-size: 0.7rem;
        font-family: monospace;
        color: var(--color-accent);
      }
      
      /* Sidebar styling */
      .sidebar {
        background: var(--color-surface);
        border-right: 1px solid rgba(255,255,255,0.1);
        min-height: 100vh;
        display: flex;
        flex-direction: column;
      }
      
      .sidebar > i-bau {
        flex: 1;
        display: flex;
        flex-direction: column;
      }
      
      .sidebar > i-bau > i-hath {
        flex: 1;
        display: flex;
        flex-direction: column;
      }
      
      /* Navigation */
      .nav-item {
        display: block;
        padding: 0.75rem 1rem;
        border-radius: 8px;
        color: var(--color-text);
        text-decoration: none;
        transition: background 0.15s, border-color 0.15s;
        border-left: 3px solid transparent;
      }
      
      .nav-item:hover {
        background: rgba(255,255,255,0.05);
      }
      
      .nav-item.active {
        background: rgba(255,255,255,0.1);
        color: var(--color-accent);
        border-left-color: var(--color-accent);
      }
      
      /* Stat cards */
      .stat-value {
        font-size: 2rem;
        font-weight: 700;
        font-variant-numeric: tabular-nums;
        color: var(--color-accent);
      }
      
      .stat-label {
        font-size: 0.85rem;
        color: var(--color-text-muted);
        text-transform: uppercase;
        letter-spacing: 0.05em;
      }
      
      /* Crew members */
      .crew-member, .crew-card {
        padding: 0.75rem;
        background: var(--color-surface-raised);
        border-radius: 8px;
      }
      
      .crew-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        background: linear-gradient(135deg, var(--color-accent), oklch(60% 0.15 200));
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 0.9rem;
        flex-shrink: 0;
      }
      
      .crew-avatar.lg {
        width: 64px;
        height: 64px;
        font-size: 1.25rem;
      }
      
      /* Log entries */
      .log-entry {
        padding: 0.5rem 0;
        border-bottom: 1px solid rgba(255,255,255,0.05);
        font-size: 0.9rem;
      }
      
      .log-time {
        color: var(--color-text-muted);
        font-size: 0.8rem;
        font-variant-numeric: tabular-nums;
      }
      
      /* Message bubbles */
      .message {
        padding: 0.75rem 1rem;
        border-radius: 12px;
        max-width: 80%;
      }
      
      .message.incoming {
        background: var(--color-surface-raised);
        border-bottom-left-radius: 4px;
      }
      
      .message.outgoing {
        background: var(--color-accent);
        color: #000;
        margin-left: auto;
        border-bottom-right-radius: 4px;
      }
      
      /* System status items */
      .system-item {
        padding: 1rem;
        background: var(--color-surface-raised);
        border-radius: 8px;
        border-left: 3px solid var(--color-success);
      }
      
      .system-item.warning {
        border-left-color: var(--color-warning);
      }
      
      .system-item.danger {
        border-left-color: var(--color-danger);
      }
      
      /* Sensor readout */
      .sensor-card {
        min-width: 200px;
        padding: 1rem;
        background: var(--color-surface);
        border-radius: 8px;
        text-align: center;
      }
      
      .sensor-value {
        font-size: 1.5rem;
        font-weight: 700;
        font-variant-numeric: tabular-nums;
      }
    </style>
    """
  end
end
