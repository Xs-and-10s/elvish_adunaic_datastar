defmodule ElvishAdunaicDatastar.MissionControl.Dashboard do
  @moduledoc """
  Dashboard page - Overview of station status.
  
  Featured Elvish primitives:
  - <i-vircantie> — Auto-fit responsive grid for stat cards
  - <i-gwistindor> — Switcher for two-column layout
  - <i-hath> — Vertical stacks throughout
  - <i-tiniath> — Horizontal clusters for buttons, badges
  """

  alias ElvishAdunaicDatastar.MissionControl.Layout

  def render do
    content = """
    <!-- Initialize Datastar signals -->
    <div data-signals="{
      oxygenLevel: 94,
      powerOutput: 87,
      hullIntegrity: 100,
      crewOnDuty: 4,
      alertsEnabled: true,
      autoScan: false,
      sensorRange: 75
    }">
    
    <!-- STATS GRID using i-vircantie (auto-fit responsive) -->
    <section>
      <i-vircantie min="200px" space="var(--s0)" style="--vircantie-min: 200px; --vircantie-space: var(--s0);">
        
        <!-- Oxygen -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <div class="stat-label">Oxygen Level</div>
            <div class="stat-value"><span data-text="$oxygenLevel">94</span>%</div>
            <an-ganad value="94" max="100" data-attr-value="$oxygenLevel"></an-ganad>
          </i-hath>
        </i-bau>
        
        <!-- Power -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <div class="stat-label">Power Output</div>
            <div class="stat-value"><span data-text="$powerOutput">87</span>%</div>
            <an-ganad value="87" max="100" data-attr-value="$powerOutput"></an-ganad>
          </i-hath>
        </i-bau>
        
        <!-- Hull -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <div class="stat-label">Hull Integrity</div>
            <div class="stat-value"><span data-text="$hullIntegrity">100</span>%</div>
            <an-ganad value="100" max="100" data-attr-value="$hullIntegrity"></an-ganad>
          </i-hath>
        </i-bau>
        
        <!-- Crew -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <div class="stat-label">Crew On Duty</div>
            <div class="stat-value"><span data-text="$crewOnDuty">4</span>/6</div>
            <i-tiniath space="var(--s-2)" style="--tiniath-space: var(--s-2);">
              <an-tabar size="sm" variant="outline" data-on:click="$crewOnDuty = Math.max(0, $crewOnDuty - 1)">−</an-tabar>
              <an-tabar size="sm" variant="outline" data-on:click="$crewOnDuty = Math.min(6, $crewOnDuty + 1)">+</an-tabar>
            </i-tiniath>
          </i-hath>
        </i-bau>
        
      </i-vircantie>
    </section>
    
    <!-- TWO COLUMN LAYOUT using i-gwistindor (switches at threshold) -->
    <section>
      <i-gwistindor threshold="700px" space="var(--s1)" limit="2" style="--gwistindor-threshold: 700px; --gwistindor-space: var(--s1); --gwistindor-limit: 2;">
        
        <!-- LEFT: Controls Panel -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            
            <div class="panel-header">
              <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                <h2>System Controls</h2>
                <an-dawar size="xs" data-show="$autoScan"></an-dawar>
              </i-tiniath>
            </div>
            
            <!-- Alert Toggle -->
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-hath space="0" style="--hath-space: 0;">
                <div>Alert Notifications</div>
                <div style="font-size: 0.85rem; color: var(--color-text-muted);">Receive system alerts</div>
              </i-hath>
              <an-zal data-on:change="$alertsEnabled = !$alertsEnabled" checked></an-zal>
            </i-tiniath>
            
            <!-- Auto Scan Toggle -->
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-hath space="0" style="--hath-space: 0;">
                <div>Auto Sensor Scan</div>
                <div style="font-size: 0.85rem; color: var(--color-text-muted);">Continuous scanning mode</div>
              </i-hath>
              <an-zal data-on:change="$autoScan = !$autoScan"></an-zal>
            </i-tiniath>
            
            <!-- Sensor Range Slider -->
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <i-tiniath space="var(--s0)" justify="space-between" style="--tiniath-space: var(--s0); --tiniath-justify: space-between;">
                <div>Sensor Range</div>
                <div style="color: var(--color-accent);"><span data-text="$sensorRange">75</span> AU</div>
              </i-tiniath>
              <an-saril min="10" max="100" value="75" show-value data-on:input="$sensorRange = this.value"></an-saril>
            </i-hath>
            
            <!-- Action Buttons -->
            <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
              <an-tabar variant="secondary" data-on:click="$oxygenLevel = 94; $powerOutput = 87; $hullIntegrity = 100">
                Reset Readings
              </an-tabar>
              <an-tabar variant="danger" data-on:click="@get('/sse/emergency')">
                Emergency Protocol
              </an-tabar>
            </i-tiniath>
            
          </i-hath>
        </i-bau>
        
        <!-- RIGHT: Activity Log -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <div class="panel-header">
              <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                <h2>Activity Log</h2>
                <an-tabar size="sm" variant="ghost" data-on:click="@get('/sse/new-log')">+ Add</an-tabar>
              </i-tiniath>
            </div>
            <div id="activity-log">
              <i-hath space="0" style="--hath-space: 0;">
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
                <div class="log-entry">
                  <div class="log-time">06:30</div>
                  <div>Hull inspection completed - no issues</div>
                </div>
              </i-hath>
            </div>
          </i-hath>
        </i-bau>
        
      </i-gwistindor>
    </section>
    
    </div>
    """

    Layout.render(
      :dashboard,
      "Dashboard",
      ["i-vircantie", "i-gwistindor", "i-hath", "i-tiniath", "i-bau"],
      content
    )
  end
end
