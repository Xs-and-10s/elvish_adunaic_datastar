defmodule ElvishAdunaicDatastar.SamplePage1 do
  @moduledoc """
  Sample page demonstrating complex Elvish layouts with Adûnaic components and Datastar reactivity.

  Theme: A "Mission Control" dashboard for a fictional space station.

  Elvish primitives used:
  - <i-glan-veleg> — Sidebar layout
  - <i-hath> — Vertical stacks
  - <i-tiniath> — Horizontal clusters
  - <i-enedh> — Centering
  - <i-bau> — Boxed panels
  - <i-vircantie> — Auto-fit grid
  - <i-gwistindor> — Row/column switcher
  """

  def render do
    """
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>Mission Control — Elvish + Adûnaic + Datastar</title>

      <!-- Elvish CSS -->
      <link rel="stylesheet" href="https://unpkg.com/elvish-css@latest/dist/elvish.min.css">
      <script src="https://unpkg.com/elvish-css@latest/dist/elvish.iife.js"></script>

      <!-- Adûnaic Components -->
      <script src="https://unpkg.com/adunaic@1.3.3/dist/adunaic.iife.js"></script>

      <!-- Datastar 1.0 -->
      <script type="module" src="https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-RC.7/bundles/datastar.js"></script>

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

        /* Panel styling for i-bau elements */
        .panel {
          background: var(--color-surface);
          border-radius: 12px;
        }

        .panel-header {
          padding-bottom: 0.75rem;
          border-bottom: 1px solid rgba(255,255,255,0.1);
        }

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

        .status-dot {
          width: 8px;
          height: 8px;
          border-radius: 50%;
          background: var(--color-success);
          animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
          0%, 100% { opacity: 1; }
          50% { opacity: 0.5; }
        }

        .crew-member {
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

        /* Sidebar navigation */
        .nav-item {
          display: block;
          padding: 0.75rem 1rem;
          border-radius: 8px;
          color: var(--color-text);
          text-decoration: none;
          transition: background 0.15s;
        }

        .nav-item:hover, .nav-item.active {
          background: rgba(255,255,255,0.1);
        }

        .nav-item.active {
          color: var(--color-accent);
          border-left: 3px solid var(--color-accent);
        }

        /* Sidebar styling */
        .sidebar {
          background: var(--color-surface);
          border-right: 1px solid rgba(255,255,255,0.1);
          min-height: 100vh;
        }
      </style>
    </head>
    <body>
      <!-- Initialize Datastar signals for the entire page -->
      <div data-signals="{
        oxygenLevel: 94,
        powerOutput: 87,
        hullIntegrity: 100,
        alertsEnabled: true,
        autoScan: false,
        sensorRange: 75,
        crewOnDuty: 4,
        systemStatus: 'nominal'
      }">

      <!-- MAIN LAYOUT: Sidebar + Content using i-glan-veleg -->
      <i-glan-veleg side="left" side-width="240px" content-min="60%" space="0">

        <!-- SIDEBAR -->
        <aside class="sidebar">
          <i-bau padding="var(--s1)">
            <i-hath space="var(--s1)">

              <!-- Logo -->
              <i-tiniath space="var(--s-1)" justify="start" align="center">
                <span style="font-size: 1.5rem;">🛸</span>
                <i-hath space="0">
                  <div style="font-weight: 600;">Station Anarion</div>
                  <div style="font-size: 0.75rem; color: var(--color-text-muted);">Mission Control</div>
                </i-hath>
              </i-tiniath>

              <!-- Navigation -->
              <nav>
                <i-hath space="var(--s-2)">
                  <a href="#" class="nav-item active">📊 Dashboard</a>
                  <a href="#" class="nav-item">👥 Crew</a>
                  <a href="#" class="nav-item">⚡ Systems</a>
                  <a href="#" class="nav-item">🛰️ Sensors</a>
                  <a href="#" class="nav-item">📡 Comms</a>
                </i-hath>
              </nav>

              <!-- System Status (pushed to bottom) -->
              <div style="margin-top: auto; padding-top: var(--s0); border-top: 1px solid rgba(255,255,255,0.1);">
                <i-tiniath space="var(--s-1)" align="center">
                  <span class="status-dot"></span>
                  <span>All Systems</span>
                  <span data-text="$systemStatus" style="color: var(--color-accent);">nominal</span>
                </i-tiniath>
              </div>

            </i-hath>
          </i-bau>
        </aside>

        <!-- MAIN CONTENT -->
        <main>
          <i-bau padding="var(--s1)">
            <i-enedh max="1200px" gutters="0">
              <i-hath space="var(--s1)">

                <!-- HEADER -->
                <header>
                  <i-tiniath space="var(--s0)" justify="space-between" align="center">
                    <i-hath space="var(--s-2)">
                      <h1>Mission Control Dashboard</h1>
                      <p style="margin: 0; color: var(--color-text-muted);">Stardate 2026.040 • Sector 7G</p>
                    </i-hath>
                    <i-tiniath space="var(--s-1)">
                      <an-tabar variant="secondary" data-on:click="@get('/sse/refresh-systems')">
                        Refresh
                      </an-tabar>
                      <an-tabar variant="primary" data-on:click="@get('/sse/run-diagnostic')">
                        Run Diagnostic
                      </an-tabar>
                    </i-tiniath>
                  </i-tiniath>
                </header>

                <!-- ALERTS -->
                <div id="alerts-container">
                  <an-hazar variant="info" dismissible>
                    <span slot="title">Scheduled Maintenance</span>
                    Reactor coolant flush scheduled for 0800 hours tomorrow.
                  </an-hazar>
                </div>

                <!-- STATS GRID using i-vircantie -->
                <i-vircantie min="200px" space="var(--s0)">

                  <!-- Oxygen -->
                  <i-bau padding="var(--s0)" class="panel">
                    <i-hath space="var(--s-1)">
                      <div class="stat-label">Oxygen Level</div>
                      <div class="stat-value"><span data-text="$oxygenLevel">94</span>%</div>
                      <an-ganad value="94" max="100" data-attr:value="$oxygenLevel"></an-ganad>
                    </i-hath>
                  </i-bau>

                  <!-- Power -->
                  <i-bau padding="var(--s0)" class="panel">
                    <i-hath space="var(--s-1)">
                      <div class="stat-label">Power Output</div>
                      <div class="stat-value"><span data-text="$powerOutput">87</span>%</div>
                      <an-ganad value="87" max="100" data-attr:value="$powerOutput"></an-ganad>
                    </i-hath>
                  </i-bau>

                  <!-- Hull -->
                  <i-bau padding="var(--s0)" class="panel">
                    <i-hath space="var(--s-1)">
                      <div class="stat-label">Hull Integrity</div>
                      <div class="stat-value"><span data-text="$hullIntegrity">100</span>%</div>
                      <an-ganad value="100" max="100" data-attr:value="$hullIntegrity"></an-ganad>
                    </i-hath>
                  </i-bau>

                  <!-- Crew -->
                  <i-bau padding="var(--s0)" class="panel">
                    <i-hath space="var(--s-1)">
                      <div class="stat-label">Crew On Duty</div>
                      <div class="stat-value"><span data-text="$crewOnDuty">4</span>/6</div>
                      <i-tiniath space="var(--s-2)">
                        <an-tabar size="sm" variant="outline" data-on:click="$crewOnDuty = Math.max(0, $crewOnDuty - 1)">−</an-tabar>
                        <an-tabar size="sm" variant="outline" data-on:click="$crewOnDuty = Math.min(6, $crewOnDuty + 1)">+</an-tabar>
                      </i-tiniath>
                    </i-hath>
                  </i-bau>

                </i-vircantie>

                <!-- TWO COLUMN LAYOUT using i-gwistindor -->
                <i-gwistindor threshold="600px" space="var(--s1)" limit="2">

                  <!-- LEFT COLUMN: Controls -->
                  <i-bau padding="var(--s0)" class="panel">
                    <i-hath space="var(--s0)">

                      <div class="panel-header">
                        <i-tiniath justify="space-between" align="center">
                          <h2>System Controls</h2>
                          <an-dawar size="xs" data-show="$autoScan"></an-dawar>
                        </i-tiniath>
                      </div>

                      <!-- Toggle: Alerts -->
                      <i-tiniath space="var(--s0)" justify="space-between" align="center">
                        <i-hath space="0">
                          <div>Alert Notifications</div>
                          <div style="font-size: 0.85rem; color: var(--color-text-muted);">Receive system alerts</div>
                        </i-hath>
                        <an-zal data-on:change="$alertsEnabled = !$alertsEnabled" checked></an-zal>
                      </i-tiniath>

                      <!-- Toggle: Auto Scan -->
                      <i-tiniath space="var(--s0)" justify="space-between" align="center">
                        <i-hath space="0">
                          <div>Auto Sensor Scan</div>
                          <div style="font-size: 0.85rem; color: var(--color-text-muted);">Continuous scanning mode</div>
                        </i-hath>
                        <an-zal data-on:change="$autoScan = !$autoScan"></an-zal>
                      </i-tiniath>

                      <!-- Slider: Sensor Range -->
                      <i-hath space="var(--s-1)">
                        <i-tiniath space="var(--s0)" justify="space-between">
                          <div>Sensor Range</div>
                          <div style="color: var(--color-accent);"><span data-text="$sensorRange">75</span> AU</div>
                        </i-tiniath>
                        <an-saril
                          min="10"
                          max="100"
                          value="75"
                          show-value
                          data-on:input="$sensorRange = this.value"
                        ></an-saril>
                      </i-hath>

                      <!-- Action Buttons -->
                      <i-tiniath space="var(--s-1)">
                        <an-tabar variant="secondary" data-on:click="$oxygenLevel = 94; $powerOutput = 87; $hullIntegrity = 100">
                          Reset Readings
                        </an-tabar>
                        <an-tabar variant="danger" data-on:click="@get('/sse/emergency')">
                          Emergency Protocol
                        </an-tabar>
                      </i-tiniath>

                    </i-hath>
                  </i-bau>

                  <!-- RIGHT COLUMN: Crew & Log -->
                  <i-hath space="var(--s0)">

                    <!-- Crew Panel -->
                    <i-bau padding="var(--s0)" class="panel">
                      <i-hath space="var(--s-1)">
                        <div class="panel-header">
                          <h2>Active Crew</h2>
                        </div>
                        <i-hath space="var(--s-1)">
                          <div class="crew-member">
                            <i-tiniath space="var(--s-1)" align="center">
                              <div class="crew-avatar">AK</div>
                              <i-hath space="0">
                                <div style="font-weight: 500;">Cmdr. A. Kowalski</div>
                                <div style="font-size: 0.8rem; color: var(--color-text-muted);">Bridge</div>
                              </i-hath>
                            </i-tiniath>
                          </div>
                          <div class="crew-member">
                            <i-tiniath space="var(--s-1)" align="center">
                              <div class="crew-avatar">TN</div>
                              <i-hath space="0">
                                <div style="font-weight: 500;">Lt. T. Nakamura</div>
                                <div style="font-size: 0.8rem; color: var(--color-text-muted);">Engineering</div>
                              </i-hath>
                            </i-tiniath>
                          </div>
                          <div class="crew-member">
                            <i-tiniath space="var(--s-1)" align="center">
                              <div class="crew-avatar">SR</div>
                              <i-hath space="0">
                                <div style="font-weight: 500;">Ens. S. Rodriguez</div>
                                <div style="font-size: 0.8rem; color: var(--color-text-muted);">Science Lab</div>
                              </i-hath>
                            </i-tiniath>
                          </div>
                        </i-hath>
                      </i-hath>
                    </i-bau>

                    <!-- Activity Log -->
                    <i-bau padding="var(--s0)" class="panel">
                      <i-hath space="var(--s-1)">
                        <div class="panel-header">
                          <i-tiniath justify="space-between" align="center">
                            <h2>Activity Log</h2>
                            <an-tabar size="sm" variant="ghost" data-on:click="@get('/sse/new-log')">
                              + Add Entry
                            </an-tabar>
                          </i-tiniath>
                        </div>
                        <div id="activity-log">
                          <i-hath space="0">
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
                          </i-hath>
                        </div>
                      </i-hath>
                    </i-bau>

                  </i-hath>
                </i-gwistindor>

                <!-- FOOTER -->
                <footer>
                  <i-enedh>
                    <i-tiniath space="var(--s1)" justify="center" align="center" style="opacity: 0.5; font-size: 0.85rem; padding-top: var(--s0);">
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

              </i-hath>
            </i-enedh>
          </i-bau>
        </main>

      </i-glan-veleg>
      </div>
    </body>
    </html>
    """
  end
end
