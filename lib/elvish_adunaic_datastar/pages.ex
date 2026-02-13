defmodule ElvishAdunaicDatastar.Pages do
  @moduledoc """
  HTML page templates using Elvish CSS, Adûnaic components, and Datastar.

  Elvish custom elements used:
  - <i-enedh> — Center (horizontally centers with max-width)
  - <i-hath> — Stack (vertical layout with gap)
  - <i-tiniath> — Cluster (horizontal flex-wrap with gap)
  - <i-bau> — Box (padding container)

  Pattern: Set BOTH the attribute AND inline style with CSS custom property
  to ensure layout works even before/if JS runs.

  Example: <i-enedh max="50%" style="--enedh-max: 50%;">
  """

  @doc """
  The main index page - "Hello Galaxy!" styled with Elvish and Adûnaic.
  """
  def index do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Elvish + Adûnaic + Datastar Testbed</title>

      <!-- Elvish CSS v2.3.0 from npm -->
      <link rel="stylesheet" href="https://unpkg.com/elvish-css@2.3.0/dist/elvish.min.css">
      <script src="https://unpkg.com/elvish-css@2.3.0/dist/elvish.iife.js"></script>

      <!-- Adûnaic Components -->
      <script src="https://unpkg.com/adunaic@1.3.3/dist/adunaic.iife.js"></script>

      <!-- Datastar 1.0 -->
      <script type="module" src="https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-RC.7/bundles/datastar.js"></script>

      <style>
        /* ============================================
           ROOT VARIABLES
           ============================================ */
        :root {
          --color-bg: #0a0a0f;
          --color-surface: #13131a;
          --color-text: #e5e5e5;
          --color-accent: oklch(75% 0.18 168);

          /* Elvish spacing scale */
          --s-2: 0.25rem;
          --s-1: 0.5rem;
          --s0: 1rem;
          --s1: 1.5rem;
          --s2: 2rem;
          --s3: 3rem;
        }

        *, *::before, *::after {
          box-sizing: border-box;
        }

        html, body {
          margin: 0;
          padding: 0;
          min-height: 100vh;
        }

        body {
          font-family: system-ui, -apple-system, sans-serif;
          background: var(--color-bg);
          color: var(--color-text);
          line-height: 1.5;
        }

        h1, h2 { margin: 0; }
        p { margin: 0; }

        /* ============================================
           COMPONENT STYLES
           ============================================ */
        .counter-display {
          font-size: 2rem;
          font-weight: bold;
          color: var(--color-accent);
          font-variant-numeric: tabular-nums;
        }

        .panel {
          background: var(--color-surface);
          border-radius: 12px;
        }

        .demo-card {
          background: var(--color-surface);
          border-radius: 12px;
          transition: transform 0.15s, box-shadow 0.15s;
        }

        .demo-card:hover {
          transform: translateY(-2px);
          box-shadow: 0 8px 24px rgba(0,0,0,0.3);
        }
      </style>
    </head>
    <body>
      <!--
        LAYOUT: Using elvish-css custom elements

        <i-enedh max="50%"> creates the 25%/50%/25% horizontal split:
        - max-inline-size: 50% limits width to half of viewport
        - margin-inline: auto centers the element horizontally

        Pattern: Set BOTH attribute AND inline style with CSS custom property
      -->
      <i-enedh max="50%" gutters="var(--s2)" style="--enedh-max: 50%; --enedh-gutters: var(--s2);">
        <i-hath space="var(--s2)" style="--hath-space: var(--s2); padding-block: var(--s3);">

          <!-- ==================== HEADER ==================== -->
          <header style="text-align: center;">
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <h1 style="font-size: 2.5rem; color: var(--color-accent);">
                🏛️ Elvish + Adûnaic + Datastar
              </h1>
              <p style="opacity: 0.7;">
                A testbed for reactive Shadow DOM components
              </p>
            </i-hath>
          </header>

          <!-- ==================== GREETING CARD ==================== -->
          <section>
            <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
              <an-hazar variant="success">
                <span slot="title">Connected!</span>
                <span id="greeting">Hello Galaxy!</span>
              </an-hazar>

              <i-tiniath space="var(--s0)" justify="center" style="--tiniath-space: var(--s0); --tiniath-justify: center;">
                <an-tabar
                  variant="primary"
                  data-on:click="@get('/sse/greet')"
                >
                  Greet the Galaxy
                </an-tabar>

                <an-tabar
                  variant="secondary"
                  data-on:click="@get('/sse/reset')"
                >
                  Reset
                </an-tabar>
              </i-tiniath>
            </i-hath>
          </section>

          <!-- ==================== COUNTER DEMO ==================== -->
          <section>
            <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
              <h2 style="font-size: 1.25rem; opacity: 0.8;">Signal Counter Demo</h2>

              <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel" data-signals="{count: 0}">
                <i-hath space="var(--s0)" style="--hath-space: var(--s0); text-align: center;">
                  <div class="counter-display" data-text="$count">0</div>

                  <i-tiniath space="var(--s-1)" justify="center" style="--tiniath-space: var(--s-1); --tiniath-justify: center;">
                    <an-tabar
                      variant="outline"
                      data-on:click="@get('/sse/increment')"
                    >
                      Increment (Server)
                    </an-tabar>

                    <an-tabar
                      variant="secondary"
                      data-on:click="$count++"
                    >
                      Increment (Client)
                    </an-tabar>

                    <an-tabar
                      variant="ghost"
                      data-on:click="$count = 0"
                    >
                      Reset
                    </an-tabar>
                  </i-tiniath>

                  <p style="font-size: 0.85rem; opacity: 0.6;">
                    "Server" makes an SSE request, "Client" updates the signal directly
                  </p>
                </i-hath>
              </i-bau>
            </i-hath>
          </section>

          <!-- ==================== LOADING STATE DEMO ==================== -->
          <section>
            <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
              <h2 style="font-size: 1.25rem; opacity: 0.8;">Loading State Demo</h2>

              <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
                <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
                  <p style="opacity: 0.7;">Click to see the concentric spinner loading state:</p>

                  <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
                    <an-tabar id="loading-demo" variant="primary">
                      Submit
                    </an-tabar>
                    <an-tabar variant="secondary" loading>
                      Loading...
                    </an-tabar>
                    <an-tabar variant="outline" loading>
                      Processing
                    </an-tabar>
                  </i-tiniath>
                </i-hath>
              </i-bau>
            </i-hath>
          </section>

          <!-- ==================== COMPONENT PREVIEW ==================== -->
          <section>
            <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
              <h2 style="font-size: 1.25rem; opacity: 0.8;">Component Preview</h2>

              <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
                <i-hath space="var(--s0)" style="--hath-space: var(--s0);">

                  <!-- Spinner -->
                  <i-tiniath space="var(--s0)" align="center" style="--tiniath-space: var(--s0); --tiniath-align: center;">
                    <an-dawar size="md"></an-dawar>
                    <span>Loading spinner with concentric rings</span>
                  </i-tiniath>

                  <!-- Progress -->
                  <an-ganad value="65" max="100" show-value>
                    Progress Bar
                  </an-ganad>

                  <!-- Switch -->
                  <an-zal id="demo-switch">Enable notifications</an-zal>

                  <!-- Buttons -->
                  <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
                    <an-tabar variant="primary" size="sm">Primary</an-tabar>
                    <an-tabar variant="secondary" size="sm">Secondary</an-tabar>
                    <an-tabar variant="outline" size="sm">Outline</an-tabar>
                    <an-tabar variant="ghost" size="sm">Ghost</an-tabar>
                  </i-tiniath>
                </i-hath>
              </i-bau>
            </i-hath>
          </section>

          <!-- ==================== SAMPLE DEMOS ==================== -->
          <section>
            <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
              <h2 style="font-size: 1.25rem; opacity: 0.8;">Sample Demos</h2>

              <a href="/sample-1" style="text-decoration: none; display: block;">
                <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="demo-card">
                  <i-tiniath space="var(--s0)" align="center" style="--tiniath-space: var(--s0); --tiniath-align: center;">
                    <span style="font-size: 2rem;">🛸</span>
                    <i-hath space="0" style="--hath-space: 0;">
                      <div style="font-weight: 600; color: var(--color-accent);">Mission Control Dashboard</div>
                      <div style="font-size: 0.9rem; opacity: 0.7;">
                        Complex layout with sidebar, stats grid, controls, and live data
                      </div>
                    </i-hath>
                    <span style="margin-left: auto; opacity: 0.5;">→</span>
                  </i-tiniath>
                </i-bau>
              </a>
            </i-hath>
          </section>

          <!-- ==================== FOOTER ==================== -->
          <footer style="text-align: center; opacity: 0.5; font-size: 0.875rem;">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <p>Elvish CSS • Adûnaic Components • Datastar SSE</p>
              <p>Running on port 1571</p>
            </i-hath>
          </footer>

        </i-hath>
      </i-enedh>

      <!-- ==================== SCRIPTS ==================== -->
      <script>
        // Demo: toggle loading on click
        document.getElementById('loading-demo')?.addEventListener('click', function() {
          this.setAttribute('loading', '');
          setTimeout(() => this.removeAttribute('loading'), 2000);
        });
      </script>

      <script type="module">
        document.addEventListener('DOMContentLoaded', () => {
          console.log('🏛️ Elvish + Adûnaic + Datastar loaded');
          console.log('Adunaic:', typeof Adunaic !== 'undefined' ? '✅ loaded' : '❌ missing');

          // Check i-enedh is working
          const enedh = document.querySelector('i-enedh');
          if (enedh) {
            const computed = getComputedStyle(enedh);
            console.log('i-enedh max-inline-size:', computed.maxInlineSize);
            console.log('i-enedh margin-inline:', computed.marginInline);
          }
        });
      </script>
    </body>
    </html>
    """
  end
end
