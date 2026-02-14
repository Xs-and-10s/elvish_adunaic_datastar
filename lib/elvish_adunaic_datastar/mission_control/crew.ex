defmodule ElvishAdunaicDatastar.MissionControl.Crew do
  @moduledoc """
  Crew page - Personnel roster and profiles.
  
  Featured Elvish primitives:
  - <i-vircantie> — Auto-fit grid for crew cards
  - <i-bau> — Box containers for profiles
  - <i-tiniath> — Horizontal clusters for badges, actions
  - <i-hath> — Vertical stacks for card content
  """

  alias ElvishAdunaicDatastar.MissionControl.Layout

  @crew_members [
    %{initials: "AK", name: "Cmdr. Anna Kowalski", role: "Station Commander", department: "Command", status: "On Duty", shift: "Alpha"},
    %{initials: "TN", name: "Lt. Taro Nakamura", role: "Chief Engineer", department: "Engineering", status: "On Duty", shift: "Alpha"},
    %{initials: "SR", name: "Ens. Sofia Rodriguez", role: "Science Officer", department: "Science", status: "On Duty", shift: "Alpha"},
    %{initials: "MK", name: "Dr. Marcus Kane", role: "Medical Officer", department: "Medical", status: "Off Duty", shift: "Beta"},
    %{initials: "LP", name: "Lt. Lena Petrova", role: "Comms Specialist", department: "Operations", status: "On Duty", shift: "Alpha"},
    %{initials: "JW", name: "Ens. James Wong", role: "Pilot", department: "Flight", status: "Off Duty", shift: "Beta"}
  ]

  def render do
    crew_cards = @crew_members
    |> Enum.map(&crew_card/1)
    |> Enum.join("\n")

    content = """
    <!-- CREW STATS -->
    <section>
      <i-tiniath space="var(--s1)" style="--tiniath-space: var(--s1);">
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-2)" style="--hath-space: var(--s-2); text-align: center;">
            <div class="stat-value" style="font-size: 1.5rem;">4/6</div>
            <div class="stat-label">On Duty</div>
          </i-hath>
        </i-bau>
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-2)" style="--hath-space: var(--s-2); text-align: center;">
            <div class="stat-value" style="font-size: 1.5rem;">Alpha</div>
            <div class="stat-label">Current Shift</div>
          </i-hath>
        </i-bau>
        <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
          <i-hath space="var(--s-2)" style="--hath-space: var(--s-2); text-align: center;">
            <div class="stat-value" style="font-size: 1.5rem;">6:42</div>
            <div class="stat-label">Until Shift Change</div>
          </i-hath>
        </i-bau>
      </i-tiniath>
    </section>
    
    <!-- CREW GRID using i-vircantie -->
    <section>
      <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
        <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center;">
          <h2>Personnel Roster</h2>
          <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
            <an-tabar size="sm" variant="outline">All</an-tabar>
            <an-tabar size="sm" variant="ghost">On Duty</an-tabar>
            <an-tabar size="sm" variant="ghost">Off Duty</an-tabar>
          </i-tiniath>
        </i-tiniath>
        
        <i-vircantie min="280px" space="var(--s0)" style="--vircantie-min: 280px; --vircantie-space: var(--s0);">
          #{crew_cards}
        </i-vircantie>
      </i-hath>
    </section>
    
    <!-- SHIFT SCHEDULE -->
    <section>
      <i-bau padding="var(--s1)" style="--bau-padding: var(--s1);" class="panel">
        <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
          <div class="panel-header">
            <h2>Shift Schedule</h2>
          </div>
          <i-vircantie min="200px" space="var(--s0)" style="--vircantie-min: 200px; --vircantie-space: var(--s0);">
            <i-bau padding="var(--s0)" style="--bau-padding: var(--s0); background: var(--color-surface-raised); border-radius: 8px; border-left: 3px solid var(--color-accent);">
              <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                <div style="font-weight: 600; color: var(--color-accent);">Alpha Shift</div>
                <div style="font-size: 0.9rem;">0600 - 1400</div>
                <div style="font-size: 0.85rem; color: var(--color-text-muted);">Currently Active</div>
              </i-hath>
            </i-bau>
            <i-bau padding="var(--s0)" style="--bau-padding: var(--s0); background: var(--color-surface-raised); border-radius: 8px; border-left: 3px solid var(--color-text-muted);">
              <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                <div style="font-weight: 600;">Beta Shift</div>
                <div style="font-size: 0.9rem;">1400 - 2200</div>
                <div style="font-size: 0.85rem; color: var(--color-text-muted);">Next Up</div>
              </i-hath>
            </i-bau>
            <i-bau padding="var(--s0)" style="--bau-padding: var(--s0); background: var(--color-surface-raised); border-radius: 8px; border-left: 3px solid var(--color-text-muted);">
              <i-hath space="var(--s-2)" style="--hath-space: var(--s-2);">
                <div style="font-weight: 600;">Gamma Shift</div>
                <div style="font-size: 0.9rem;">2200 - 0600</div>
                <div style="font-size: 0.85rem; color: var(--color-text-muted);">Night Watch</div>
              </i-hath>
            </i-bau>
          </i-vircantie>
        </i-hath>
      </i-bau>
    </section>
    """

    Layout.render(
      :crew,
      "Crew",
      ["i-vircantie", "i-bau", "i-tiniath", "i-hath"],
      content
    )
  end

  defp crew_card(member) do
    status_color = if member.status == "On Duty", do: "var(--color-success)", else: "var(--color-text-muted)"
    
    """
    <i-bau padding="var(--s0)" style="--bau-padding: var(--s0);" class="panel">
      <i-hath space="var(--s0)" style="--hath-space: var(--s0);">
        <i-tiniath space="var(--s0)" align="center" style="--tiniath-space: var(--s0); --tiniath-align: center;">
          <div class="crew-avatar lg">#{member.initials}</div>
          <i-hath space="0" style="--hath-space: 0; flex: 1;">
            <div style="font-weight: 600;">#{member.name}</div>
            <div style="font-size: 0.85rem; color: var(--color-text-muted);">#{member.role}</div>
          </i-hath>
        </i-tiniath>
        
        <i-tiniath space="var(--s-1)" style="--tiniath-space: var(--s-1);">
          <span class="primitive-tag" style="background: rgba(255,255,255,0.05);">#{member.department}</span>
          <span class="primitive-tag" style="background: rgba(255,255,255,0.05);">#{member.shift} Shift</span>
        </i-tiniath>
        
        <i-tiniath space="var(--s0)" justify="space-between" align="center" style="--tiniath-space: var(--s0); --tiniath-justify: space-between; --tiniath-align: center; padding-top: var(--s-1); border-top: 1px solid rgba(255,255,255,0.1);">
          <i-tiniath space="var(--s-2)" align="center" style="--tiniath-space: var(--s-2); --tiniath-align: center;">
            <span class="status-dot" style="background: #{status_color}; animation: none;"></span>
            <span style="font-size: 0.85rem;">#{member.status}</span>
          </i-tiniath>
          <an-tabar size="sm" variant="ghost">View Profile</an-tabar>
        </i-tiniath>
      </i-hath>
    </i-bau>
    """
  end
end
