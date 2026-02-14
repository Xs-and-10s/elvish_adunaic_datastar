defmodule ElvishAdunaicDatastar.MissionControl.Systems do
  @moduledoc """
  Systems page - Station subsystems monitoring.
  
  Featured Elvish primitives:
  - <i-miriant> — Explicit grid with defined columns
  - <i-hath> — Vertical stacks for status lists
  - <i-bau> — Box containers for system panels
  - <i-tiniath> — Horizontal clusters for actions
  """

  alias ElvishAdunaicDatastar.MissionControl.Layout

  def render do
    content = """
    <!-- Initialize Datastar signals -->
    <div data-signals="{
      lifeSupportStatus: 'nominal',
      powerGridStatus: 'nominal',
      propulsionStatus: 'standby',
      environmentalStatus: 'nominal',
      navigationStatus: 'nominal',
      shieldStatus: 'warning'
    }">
    
    <!-- SYSTEMS GRID using i-miriant (explicit 2-column grid) -->
    <section>
      <i-miriant columns="2" space="var(--s1)" style="--miriant-columns: 2; --miriant-space: var(--s1);">
        
        <!-- Life Support -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                <span style="font-size: 1.5rem;">🫁</span>
                <h2>Life Support</h2>
              </i-tiniath>
              <span class="status-dot"></span>
            </i-tiniath>
            
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Oxygen Generation</span>
                  <span style="color: var(--color-success);">100%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>CO₂ Scrubbers</span>
                  <span style="color: var(--color-success);">98%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Water Recycling</span>
                  <span style="color: var(--color-success);">95%</span>
                </i-tiniath>
              </div>
            </i-hath>
          </i-hath>
        </i-bau>
        
        <!-- Power Grid -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                <span style="font-size: 1.5rem;">⚡</span>
                <h2>Power Grid</h2>
              </i-tiniath>
              <span class="status-dot"></span>
            </i-tiniath>
            
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Main Reactor</span>
                  <span style="color: var(--color-success);">87%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Solar Arrays</span>
                  <span style="color: var(--color-success);">92%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Battery Banks</span>
                  <span style="color: var(--color-success);">100%</span>
                </i-tiniath>
              </div>
            </i-hath>
          </i-hath>
        </i-bau>
        
        <!-- Propulsion -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                <span style="font-size: 1.5rem;">🚀</span>
                <h2>Propulsion</h2>
              </i-tiniath>
              <span class="status-dot" style="background: var(--color-text-muted); animation: none;"></span>
            </i-tiniath>
            
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <div class="system-item" style="border-left-color: var(--color-text-muted);">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Main Engines</span>
                  <span style="color: var(--color-text-muted);">Standby</span>
                </i-tiniath>
              </div>
              <div class="system-item" style="border-left-color: var(--color-text-muted);">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Maneuvering Thrusters</span>
                  <span style="color: var(--color-success);">Ready</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Fuel Reserves</span>
                  <span style="color: var(--color-success);">78%</span>
                </i-tiniath>
              </div>
            </i-hath>
          </i-hath>
        </i-bau>
        
        <!-- Shields -->
        <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
              <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                <span style="font-size: 1.5rem;">🛡️</span>
                <h2>Shields</h2>
              </i-tiniath>
              <span class="status-dot" style="background: var(--color-warning);"></span>
            </i-tiniath>
            
            <i-hath space="var(--s-1)" style="--hath-space: var(--s-1);">
              <div class="system-item warning">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Forward Array</span>
                  <span style="color: var(--color-warning);">67%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Aft Array</span>
                  <span style="color: var(--color-success);">94%</span>
                </i-tiniath>
              </div>
              <div class="system-item">
                <i-tiniath justify="space-between" style="--tiniath-justify: space-between;">
                  <span>Radiation Shielding</span>
                  <span style="color: var(--color-success);">100%</span>
                </i-tiniath>
              </div>
            </i-hath>
            
            <an-tabar variant="warning" size="sm" block>Repair Forward Array</an-tabar>
          </i-hath>
        </i-bau>
        
      </i-miriant>
    </section>
    
    <!-- SYSTEM ACTIONS -->
    <section>
      <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
        <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
          <div class="panel-header">
            <h2>System Actions</h2>
          </div>
          <i-tiniath space="var(--s0)" style="--tiniath-space: var(--s0);">
            <an-tabar variant="secondary">Run Diagnostics</an-tabar>
            <an-tabar variant="secondary">Optimize Power</an-tabar>
            <an-tabar variant="secondary">Backup Systems</an-tabar>
            <an-tabar variant="danger">Emergency Shutdown</an-tabar>
          </i-tiniath>
        </i-hath>
      </i-bau>
    </section>
    
    </div>
    """

    Layout.render(
      :systems,
      "Systems",
      ["i-miriant", "i-hath", "i-bau", "i-tiniath"],
      content
    )
  end
end
