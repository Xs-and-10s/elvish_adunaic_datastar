defmodule ElvishAdunaicDatastar.Pages do
  @moduledoc """
  HTML page templates using Elvish CSS, Adûnaic components, and Datastar.
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
      
      <!-- Elvish CSS (from npm/CDN) -->
      <link rel="stylesheet" href="https://unpkg.com/elvish-css@latest/dist/elvish.min.css">
      
      <!-- Adûnaic Components - published npm package -->
      <script src="https://unpkg.com/adunaic@1.3.3/dist/adunaic.iife.js"></script>
      
      <!-- Datastar 1.0 -->
      <script type="module" src="https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-RC.7/bundles/datastar.js"></script>
      
      <!-- Local overrides / custom styles -->
      <link rel="stylesheet" href="/static/css/app.css">
      
      <style>
        :root {
          --color-bg: #0a0a0f;
          --color-surface: #13131a;
          --color-text: #e5e5e5;
          --color-accent: oklch(75% 0.18 168);
        }
        
        body {
          font-family: system-ui, -apple-system, sans-serif;
          background: var(--color-bg);
          color: var(--color-text);
          margin: 0;
          min-height: 100vh;
        }
        
        .counter-display {
          font-size: 2rem;
          font-weight: bold;
          color: var(--color-accent);
          font-variant-numeric: tabular-nums;
        }
      </style>
    </head>
    <body>
      <main class="el-center el-stack" style="--stack-gap: 2rem; padding: 2rem; min-height: 100vh;">
        
        <!-- Header -->
        <header class="el-stack" style="--stack-gap: 0.5rem; text-align: center;">
          <h1 style="font-size: 2.5rem; margin: 0; color: var(--color-accent, oklch(75% 0.18 168));">
            🏛️ Elvish + Adûnaic + Datastar
          </h1>
          <p style="opacity: 0.7; margin: 0;">
            A testbed for reactive Shadow DOM components
          </p>
        </header>
        
        <!-- Main greeting card using Adûnaic alert -->
        <section class="el-stack" style="--stack-gap: 1rem; max-width: 600px; width: 100%;">
          <an-hazar variant="success">
            <span slot="title">Connected!</span>
            <span id="greeting">Hello Galaxy!</span>
          </an-hazar>
          
          <!-- Adûnaic Buttons with Datastar SSE actions -->
          <!-- Note: data-on:click with colon, @get() with @ prefix -->
          <div class="el-cluster" style="--cluster-gap: 1rem; justify-content: center;">
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
          </div>
        </section>
        
        <!-- Counter demo with signals -->
        <section class="el-stack" style="--stack-gap: 1rem; max-width: 600px; width: 100%;">
          <h2 style="font-size: 1.25rem; margin: 0; opacity: 0.8;">Signal Counter Demo</h2>
          
          <div 
            class="el-stack" 
            style="--stack-gap: 0.75rem; background: var(--color-surface, #13131a); padding: 1.5rem; border-radius: 12px; text-align: center;"
            data-signals="{count: 0}"
          >
            <div class="counter-display" data-text="$count">0</div>
            
            <div class="el-cluster" style="--cluster-gap: 0.5rem; justify-content: center;">
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
            </div>
            
            <p style="font-size: 0.85rem; opacity: 0.6; margin: 0;">
              "Server" makes an SSE request, "Client" updates the signal directly
            </p>
          </div>
        </section>
        
        <!-- Loading button demo -->
        <section class="el-stack" style="--stack-gap: 1rem; max-width: 600px; width: 100%;">
          <h2 style="font-size: 1.25rem; margin: 0; opacity: 0.8;">Loading State Demo</h2>
          
          <div class="el-stack" style="--stack-gap: 0.75rem; background: var(--color-surface, #13131a); padding: 1.5rem; border-radius: 12px;">
            <p style="margin: 0; opacity: 0.7;">Click to see the concentric spinner loading state:</p>
            
            <div class="el-cluster" style="--cluster-gap: 0.5rem;">
              <an-tabar id="loading-demo" variant="primary">
                Submit
              </an-tabar>
              <an-tabar variant="secondary" loading>
                Loading...
              </an-tabar>
              <an-tabar variant="outline" loading>
                Processing
              </an-tabar>
            </div>
            
            <script>
              // Demo: toggle loading on click
              document.getElementById('loading-demo')?.addEventListener('click', function() {
                this.setAttribute('loading', '');
                setTimeout(() => this.removeAttribute('loading'), 2000);
              });
            </script>
          </div>
        </section>
        
        <!-- Component showcase preview -->
        <section class="el-stack" style="--stack-gap: 1rem; max-width: 600px; width: 100%;">
          <h2 style="font-size: 1.25rem; margin: 0; opacity: 0.8;">Component Preview</h2>
          
          <div class="el-stack" style="--stack-gap: 0.75rem; background: var(--color-surface, #13131a); padding: 1.5rem; border-radius: 12px;">
            
            <!-- Spinner -->
            <div class="el-cluster" style="--cluster-gap: 1rem; align-items: center;">
              <an-dawar size="md"></an-dawar>
              <span>Loading spinner with concentric rings</span>
            </div>
            
            <!-- Progress -->
            <an-ganad value="65" max="100" show-value>
              Progress Bar
            </an-ganad>
            
            <!-- Switch -->
            <an-zal id="demo-switch">Enable notifications</an-zal>
            
            <!-- Buttons -->
            <div class="el-cluster" style="--cluster-gap: 0.5rem;">
              <an-tabar variant="primary" size="sm">Primary</an-tabar>
              <an-tabar variant="secondary" size="sm">Secondary</an-tabar>
              <an-tabar variant="outline" size="sm">Outline</an-tabar>
              <an-tabar variant="ghost" size="sm">Ghost</an-tabar>
            </div>
          </div>
        </section>
        
        <!-- Info footer -->
        <footer style="text-align: center; opacity: 0.5; font-size: 0.875rem;">
          <p>
            Elvish CSS • Adûnaic Components • Datastar SSE
          </p>
          <p>
            Running on port 1571
          </p>
        </footer>
        
      </main>
      
      <!-- Debug info -->
      <script type="module">
        document.addEventListener('DOMContentLoaded', () => {
          console.log('🏛️ Elvish + Adûnaic + Datastar loaded');
          console.log('Adunaic:', typeof Adunaic !== 'undefined' ? '✅ loaded' : '❌ missing');
          
          // Check if a button has forwarded attributes
          setTimeout(() => {
            const btn = document.querySelector('an-tabar[data-on\\\\:click]');
            if (btn && btn.shadowRoot) {
              const innerBtn = btn.shadowRoot.querySelector('button');
              const hasAttr = innerBtn?.hasAttribute('data-on:click');
              console.log('Attribute forwarding:', hasAttr ? '✅ working' : '❌ not working');
            }
          }, 100);
        });
      </script>
    </body>
    </html>
    """
  end
end
