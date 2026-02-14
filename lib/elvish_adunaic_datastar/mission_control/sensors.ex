defmodule ElvishAdunaicDatastar.MissionControl.Sensors do
  @moduledoc """
  Sensors page - Environmental and external monitoring.
  
  Featured Elvish primitives:
  - <i-glan-tholl> — Reel/horizontal scrolling for sensor readouts
  - <i-gant-thala> — Aspect ratio containers for charts
  - <i-vircantie> — Grid for sensor categories
  - <i-hath> — Vertical stacks
  """

  alias ElvishAdunaicDatastar.MissionControl.Layout

  def render do
    content = """
    <!-- Initialize Datastar signals for live updates -->
    <div data-signals="{
      sensorRange: 75,
      scanActive: false,
      lastScan: '07:42:15',
      objectsDetected: 3
    }">
    
    <!-- LIVE SENSOR READOUTS using i-glan-tholl (horizontal scroll) -->
    <section>
      <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
        <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
          <h2>Live Sensor Readouts</h2>
          <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
            <an-dawar size="xs" data-show="$scanActive"></an-dawar>
            <an-tabar size="sm" variant="primary" data-on:click="$scanActive = !$scanActive">
              <span data-text="$scanActive ? 'Stop Scan' : 'Start Scan'">Start Scan</span>
            </an-tabar>
          </i-tiniath>
        </i-tiniath>
        
        <!-- Horizontal scrolling sensor cards -->
        <i-glan-tholl item-width="180px" space="var(--s0)" style="--glan-tholl-item-width: 180px; --glan-tholl-space: var(--s0);">
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">🌡️</div>
              <div class="sensor-value" style="color: var(--color-success);">21.4°C</div>
              <div class="stat-label">Internal Temp</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">💨</div>
              <div class="sensor-value" style="color: var(--color-success);">101.3</div>
              <div class="stat-label">Pressure (kPa)</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">💧</div>
              <div class="sensor-value" style="color: var(--color-success);">45%</div>
              <div class="stat-label">Humidity</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">☢️</div>
              <div class="sensor-value" style="color: var(--color-success);">0.12</div>
              <div class="stat-label">Radiation (mSv)</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">🧲</div>
              <div class="sensor-value" style="color: var(--color-warning);">2.4</div>
              <div class="stat-label">Mag Field (μT)</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">🔊</div>
              <div class="sensor-value" style="color: var(--color-success);">32</div>
              <div class="stat-label">Noise (dB)</div>
            </i-hath>
          </div>
          <div class="sensor-card">
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <div style="font-size: 1.5rem;">⚡</div>
              <div class="sensor-value" style="color: var(--color-success);">0.02</div>
              <div class="stat-label">EM Interference</div>
            </i-hath>
          </div>
        </i-glan-tholl>
        <div style="text-align: center; font-size: 0.8rem; color: var(--color-text-muted);">← Scroll for more sensors →</div>
      </i-hath>
    </section>
    
    <!-- EXTERNAL SENSORS using i-gant-thala for chart area -->
    <section>
      <i-gwistindor threshold="700px" space="var(--s1)" limit="2" style="--gwistindor-threshold: 700px; --gwistindor-space: var(--s1); --gwistindor-limit: 2;">
        
        <!-- Radar Display -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <div class="panel-header">
              <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                <h2>Proximity Radar</h2>
                <span style="font-size: 0.85rem; color: var(--color-text-muted);">Range: <span data-text="$sensorRange">75</span> AU</span>
              </i-tiniath>
            </div>
            
            <!-- Aspect ratio container for radar display -->
            <i-gant-thala ratio="1:1" style="max-width: 300px; margin: 0 auto;">
              <div style="
                width: 100%;
                height: 100%;
                background: radial-gradient(circle, rgba(0,255,150,0.1) 0%, transparent 70%);
                border: 2px solid var(--color-accent);
                border-radius: 50%;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
              ">
                <!-- Radar sweep animation -->
                <div style="
                  position: absolute;
                  width: 50%;
                  height: 2px;
                  background: linear-gradient(90deg, var(--color-accent), transparent);
                  transform-origin: left center;
                  animation: radar-sweep 4s linear infinite;
                "></div>
                <!-- Center dot -->
                <div style="
                  width: 8px;
                  height: 8px;
                  background: var(--color-accent);
                  border-radius: 50%;
                "></div>
                <!-- Detected objects -->
                <div style="position: absolute; top: 25%; left: 60%; width: 6px; height: 6px; background: var(--color-warning); border-radius: 50%;"></div>
                <div style="position: absolute; top: 70%; left: 30%; width: 6px; height: 6px; background: var(--color-success); border-radius: 50%;"></div>
                <div style="position: absolute; top: 40%; left: 20%; width: 6px; height: 6px; background: var(--color-success); border-radius: 50%;"></div>
              </div>
            </i-gant-thala>
            
            <style>
              @keyframes radar-sweep {
                from { transform: rotate(0deg); }
                to { transform: rotate(360deg); }
              }
            </style>
            
            <i-tiniath justify="center" space="var(--s1)" style="--tiniath-justify: center; --tiniath-space: var(--s1); margin-top: var(--s0);">
              <i-hath space="0" style="--hath-space: 0; text-align: center;">
                <div style="font-size: 1.25rem; font-weight: 600;" data-text="$objectsDetected">3</div>
                <div class="stat-label">Objects Detected</div>
              </i-hath>
            </i-tiniath>
          </i-hath>
        </i-bau>
        
        <!-- Detected Objects List -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <div class="panel-header">
              <h2>Detected Objects</h2>
            </div>
            
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <div class="system-item">
                <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                  <i-hath space="0" style="--hath-space: 0;">
                    <div style="font-weight: 500;">Asteroid A-7742</div>
                    <div style="font-size: 0.85rem; color: var(--color-text-muted);">12.4 AU • Bearing 045°</div>
                  </i-hath>
                  <span class="primitive-tag" style="background: rgba(var(--color-success), 0.2); color: var(--color-success);">Safe</span>
                </i-tiniath>
              </div>
              <div class="system-item warning">
                <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                  <i-hath space="0" style="--hath-space: 0;">
                    <div style="font-weight: 500;">Unknown Vessel</div>
                    <div style="font-size: 0.85rem; color: var(--color-text-muted);">8.1 AU • Bearing 120°</div>
                  </i-hath>
                  <span class="primitive-tag" style="background: rgba(255,200,0,0.2); color: var(--color-warning);">Tracking</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                  <i-hath space="0" style="--hath-space: 0;">
                    <div style="font-weight: 500;">Comm Satellite CS-19</div>
                    <div style="font-size: 0.85rem; color: var(--color-text-muted);">2.3 AU • Bearing 270°</div>
                  </i-hath>
                  <span class="primitive-tag" style="background: rgba(0,255,150,0.2); color: var(--color-success);">Friendly</span>
                </i-tiniath>
              </div>
            </i-hath>
            
            <an-tabar variant="outline" size="sm" block>Full Scan Report</an-tabar>
          </i-hath>
        </i-bau>
        
      </i-gwistindor>
    </section>
    
    <!-- SENSOR CONTROLS -->
    <section>
      <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
        <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
          <div class="panel-header">
            <h2>Sensor Configuration</h2>
          </div>
          
          <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <span>Sensor Range</span>
              <span style="color: var(--color-accent);"><span data-text="$sensorRange">75</span> AU</span>
            </i-tiniath>
            <an-saril min="10" max="150" value="75" show-value data-on:input="$sensorRange = this.value"></an-saril>
          </i-hath>
          
          <i-tiniath space="var(--s0)" style="--tiniath-space: var(--s0);">
            <an-tabar variant="secondary">Calibrate Sensors</an-tabar>
            <an-tabar variant="secondary">Reset to Defaults</an-tabar>
            <an-tabar variant="primary">Deep Space Scan</an-tabar>
          </i-tiniath>
        </i-hath>
      </i-bau>
    </section>
    
    </div>
    """

    Layout.render(
      :sensors,
      "Sensors",
      ["i-glan-tholl", "i-gant-thala", "i-gwistindor", "i-vircantie", "i-hath"],
      content
    )
  end
end
