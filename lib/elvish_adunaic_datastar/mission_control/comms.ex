defmodule ElvishAdunaicDatastar.MissionControl.Comms do
  @moduledoc """
  Comms page - Communications and messaging.
  
  Featured Elvish primitives:
  - <i-esgal> — Cover/vertical centering for compose area
  - <i-hath> — Vertical stacks for message threads
  - <i-glan-veleg> — Sidebar layout for channels list
  - <i-tiniath> — Horizontal clusters
  """

  alias ElvishAdunaicDatastar.MissionControl.Layout

  def render do
    content = """
    <!-- Initialize Datastar signals -->
    <div data-signals="{
      activeChannel: 'bridge',
      messageText: '',
      signalStrength: 94,
      sending: false
    }">
    
    <!-- COMMS STATUS BAR -->
    <section>
      <i-tiniath space="var(--s1)" style="--tiniath-space: var(--s1);">
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
            <span style="font-size: 1.25rem;">📡</span>
            <i-hath space="0" style="--hath-space: 0;">
              <div style="font-weight: 600;">Signal Strength</div>
              <div style="font-size: 0.85rem; color: var(--color-success);"><span data-text="$signalStrength">94</span>%</div>
            </i-hath>
          </i-tiniath>
        </i-bau>
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
            <span style="font-size: 1.25rem;">🔗</span>
            <i-hath space="0" style="--hath-space: 0;">
              <div style="font-weight: 600;">Active Relays</div>
              <div style="font-size: 0.85rem; color: var(--color-text-muted);">3 of 4</div>
            </i-hath>
          </i-tiniath>
        </i-bau>
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
            <span style="font-size: 1.25rem;">⏱️</span>
            <i-hath space="0" style="--hath-space: 0;">
              <div style="font-weight: 600;">Signal Delay</div>
              <div style="font-size: 0.85rem; color: var(--color-text-muted);">2.4s to Earth</div>
            </i-hath>
          </i-tiniath>
        </i-bau>
      </i-tiniath>
    </section>
    
    <!-- MAIN COMMS INTERFACE using nested i-glan-veleg -->
    <section>
      <i-glan-veleg side="left" side-width="200px" content-min="60%" space="var(--s0)" style="--glan-veleg-width: 200px; --glan-veleg-content-min: 60%; --glan-veleg-space: var(--s0); min-height: 500px;">
        
        <!-- CHANNELS SIDEBAR -->
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
            <div class="panel-header">
              <h3 style="font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--color-text-muted);">Channels</h3>
            </div>
            
            <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
              <a href="#" class="nav-item" data-class:active="$activeChannel === 'bridge'" data-on:click__prevent="$activeChannel = 'bridge'" style="padding: 0.5rem 0.75rem;">
                <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                  <span>🎯</span>
                  <span>Bridge</span>
                </i-tiniath>
              </a>
              <a href="#" class="nav-item" data-class:active="$activeChannel === 'engineering'" data-on:click__prevent="$activeChannel = 'engineering'" style="padding: 0.5rem 0.75rem;">
                <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                  <span>🔧</span>
                  <span>Engineering</span>
                </i-tiniath>
              </a>
              <a href="#" class="nav-item" data-class:active="$activeChannel === 'science'" data-on:click__prevent="$activeChannel = 'science'" style="padding: 0.5rem 0.75rem;">
                <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                  <span>🔬</span>
                  <span>Science Lab</span>
                </i-tiniath>
              </a>
              <a href="#" class="nav-item" data-class:active="$activeChannel === 'medical'" data-on:click__prevent="$activeChannel = 'medical'" style="padding: 0.5rem 0.75rem;">
                <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                  <span>🏥</span>
                  <span>Medical</span>
                </i-tiniath>
              </a>
            </i-hath>
            
            <div style="margin-top: var(--s1); padding-top: var(--s0); border-top: 1px solid rgba(255,255,255,0.1);">
              <div class="panel-header">
                <h3 style="font-size: 0.9rem; text-transform: uppercase; letter-spacing: 0.05em; color: var(--color-text-muted);">Direct</h3>
              </div>
              <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                <a href="#" class="nav-item" data-class:active="$activeChannel === 'kowalski'" data-on:click__prevent="$activeChannel = 'kowalski'" style="padding: 0.5rem 0.75rem;">
                  <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                    <div class="crew-avatar" style="width: 24px; height: 24px; font-size: 0.6rem;">AK</div>
                    <span>Cmdr. Kowalski</span>
                  </i-tiniath>
                </a>
                <a href="#" class="nav-item" data-class:active="$activeChannel === 'earth'" data-on:click__prevent="$activeChannel = 'earth'" style="padding: 0.5rem 0.75rem;">
                  <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                    <span>🌍</span>
                    <span>Earth Command</span>
                  </i-tiniath>
                </a>
              </i-hath>
            </div>
          </i-hath>
        </i-bau>
        
        <!-- MESSAGE AREA -->
        <i-bau padding="0" style="--bau-padding: 0;" class="panel">
          <i-hath space="0" style="--hath-space: 0; height: 100%; display: flex; flex-direction: column;">
            
            <!-- Channel Header -->
            <div style="padding: var(--s0); border-bottom: 1px solid rgba(255,255,255,0.1);">
              <i-tiniath justify="space-between" align="center" style="--tiniath-justify: space-between; --tiniath-align: center;">
                <i-tiniath space="var(--s-1)" align="center" style="--tiniath-space: var(--s-1); --tiniath-align: center;">
                  <!-- Channel icon -->
                  <span style="font-size: 1.25rem;" data-show="$activeChannel === 'bridge'">🎯</span>
                  <span style="font-size: 1.25rem;" data-show="$activeChannel === 'engineering'">🔧</span>
                  <span style="font-size: 1.25rem;" data-show="$activeChannel === 'science'">🔬</span>
                  <span style="font-size: 1.25rem;" data-show="$activeChannel === 'medical'">🏥</span>
                  <div class="crew-avatar" style="width: 32px; height: 32px; font-size: 0.7rem;" data-show="$activeChannel === 'kowalski'">AK</div>
                  <span style="font-size: 1.25rem;" data-show="$activeChannel === 'earth'">🌍</span>
                  
                  <i-hath space="0" style="--hath-space: 0;">
                    <!-- Channel name -->
                    <div style="font-weight: 600;">
                      <span data-show="$activeChannel === 'bridge'">\#bridge</span>
                      <span data-show="$activeChannel === 'engineering'">\#engineering</span>
                      <span data-show="$activeChannel === 'science'">\#science</span>
                      <span data-show="$activeChannel === 'medical'">\#medical</span>
                      <span data-show="$activeChannel === 'kowalski'">Cmdr. Kowalski</span>
                      <span data-show="$activeChannel === 'earth'">Earth Command</span>
                    </div>
                    <!-- Channel subtitle -->
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">
                      <span data-show="$activeChannel === 'bridge'">4 members online</span>
                      <span data-show="$activeChannel === 'engineering'">3 members online</span>
                      <span data-show="$activeChannel === 'science'">2 members online</span>
                      <span data-show="$activeChannel === 'medical'">2 members online</span>
                      <span data-show="$activeChannel === 'kowalski'">Station Commander</span>
                      <span data-show="$activeChannel === 'earth'">2.4s signal delay</span>
                    </div>
                  </i-hath>
                </i-tiniath>
                <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
                  <an-tabar size="sm" variant="ghost">📌</an-tabar>
                  <an-tabar size="sm" variant="ghost">⚙️</an-tabar>
                </i-tiniath>
              </i-tiniath>
            </div>
            
            <!-- Messages using i-esgal for vertical distribution -->
            <i-esgal min-height="300px" space="var(--s0)" style="--esgal-min-height: 300px; --esgal-space: var(--s0); flex: 1; padding: var(--s0); overflow-y: auto;">
              
              <!-- Spacer pushes content down -->
              <div></div>
              
              <!-- BRIDGE CHANNEL MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'bridge'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Lt. Nakamura • 07:38</div>
                    <div>Power grid optimization complete. Running at 92% efficiency now.</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • 07:40</div>
                    <div>Excellent work! Any issues with the solar array calibration?</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Lt. Nakamura • 07:41</div>
                    <div>Minor alignment drift on Array 3. Scheduled auto-correction for 0800.</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Cmdr. Kowalski • 07:42</div>
                    <div>Good morning team. Status report looks green across the board. Let's keep it that way. 👍</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- ENGINEERING CHANNEL MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'engineering'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Lt. Nakamura • 06:15</div>
                    <div>Starting reactor diagnostics. ETA 45 minutes.</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Ens. Wong • 06:32</div>
                    <div>Coolant pressure nominal. All pumps operational.</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • 06:45</div>
                    <div>Can we boost output to 95% for the sensor sweep?</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Lt. Nakamura • 06:48</div>
                    <div>Affirmative. Ramping up now. Will hold at 95% for 30 minutes max.</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- SCIENCE LAB CHANNEL MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'science'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Ens. Rodriguez • 05:30</div>
                    <div>Spectral analysis of the asteroid sample is complete. Fascinating composition!</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • 05:45</div>
                    <div>What did you find? Anything unusual?</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Ens. Rodriguez • 05:52</div>
                    <div>High concentration of rare earth elements. Also traces of an unknown crystalline structure. Requesting extended analysis time. 🔬</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- MEDICAL CHANNEL MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'medical'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Dr. Kane • 04:00</div>
                    <div>Quarterly health checks scheduled for next week. Please sign up for your slot.</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Dr. Kane • 07:00</div>
                    <div>Reminder: Vitamin D supplements are available. See me if you need a refill. ☀️</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • 07:10</div>
                    <div>Thanks Doc! I'll swing by after my shift.</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- DIRECT: KOWALSKI MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'kowalski'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Cmdr. Kowalski • Yesterday</div>
                    <div>I've reviewed your proposal for the sensor array upgrade. Good work.</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • Yesterday</div>
                    <div>Thank you, Commander. When can we schedule the installation?</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Cmdr. Kowalski • 06:00</div>
                    <div>Let's plan for next rotation. I'll add it to the maintenance schedule. Keep up the excellent work! 🌟</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- DIRECT: EARTH COMMAND MESSAGES -->
              <i-hath space="var(--s0)" style="--hath-space: var(--s0);" data-centered data-show="$activeChannel === 'earth'">
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Earth Command • 2 days ago</div>
                    <div>Station Anarion, this is Earth Command. Please confirm receipt of supply manifest for next month's resupply mission.</div>
                  </i-hath>
                </div>
                
                <div class="message outgoing">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; opacity: 0.7;">You • 2 days ago</div>
                    <div>Earth Command, manifest received and confirmed. Requesting additional medical supplies - see attached requisition.</div>
                  </i-hath>
                </div>
                
                <div class="message incoming">
                  <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                    <div style="font-size: 0.8rem; color: var(--color-text-muted);">Earth Command • Yesterday</div>
                    <div>Requisition approved. ETA for resupply: 14 days. Stay safe out there, Anarion. 🚀</div>
                  </i-hath>
                </div>
                
              </i-hath>
              
              <!-- Container for dynamically added messages -->
              <div id="new-messages">
                <i-hath space="var(--s0)" style="--hath-space: var(--s0);"></i-hath>
              </div>
              
              <!-- Bottom spacer -->
              <div></div>
              
            </i-esgal>
            
            <!-- Compose Area -->
            <div style="padding: var(--s0); border-top: 1px solid rgba(255,255,255,0.1); background: var(--color-surface-raised);">
              <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
                <input 
                  type="text" 
                  placeholder="Type a message..." 
                  style="
                    flex: 1;
                    padding: 0.75rem 1rem;
                    background: var(--color-surface);
                    border: 1px solid rgba(255,255,255,0.1);
                    border-radius: 8px;
                    color: var(--color-text);
                    font-family: inherit;
                    font-size: 0.95rem;
                  "
                  data-bind:message-text
                >
                <an-tabar variant="primary" data-on:click="@post('/sse/send-message')" data-indicator:sending data-attr:disabled="$sending || $messageText === ''">
                  <span data-show="!$sending">Send</span>
                  <span data-show="$sending">...</span>
                </an-tabar>
              </i-tiniath>
            </div>
            
          </i-hath>
        </i-bau>
        
      </i-glan-veleg>
    </section>
    
    <!-- BROADCAST CONTROLS -->
    <section>
      <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
        <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
          <div class="panel-header">
            <h2>Broadcast Controls</h2>
          </div>
          <i-tiniath space="var(--s0)" style="--tiniath-space: var(--s0);">
            <an-tabar variant="secondary">📢 Station-wide Announcement</an-tabar>
            <an-tabar variant="secondary">🔔 Emergency Alert</an-tabar>
            <an-tabar variant="outline">📝 View Message Log</an-tabar>
          </i-tiniath>
        </i-hath>
      </i-bau>
    </section>
    
    </div>
    """

    Layout.render(
      :comms,
      "Comms",
      ["i-esgal", "i-glan-veleg", "i-hath", "i-tiniath", "i-bau"],
      content
    )
  end
end
