defmodule ElvishAdunaicDatastar.MixProject do
  use Mix.Project

  def project do
    [
      app: :elvish_adunaic_datastar,
      version: "0.1.1",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {ElvishAdunaicDatastar.Application, []}
    ]
  end

  defp deps do
    [
      # Web server
      {:bandit, "~> 1.0"},
      {:plug, "~> 1.15"},

      # Datastar SSE support
      {:datastar_ex, "~> 0.1.0"},

      # JSON encoding
      {:jason, "~> 1.4"}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "cmd npm install"]
    ]
  end
end
