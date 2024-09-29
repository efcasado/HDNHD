defmodule Hdnhd.MixProject do
  use Mix.Project

  def project do
    [
      app: :hdnhd,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {HDNHD, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bumblebee, "~> 0.5.3"},
      {:exla, "~> 0.7.0"},
      {:httpoison, "~> 2.2"},
      {:image, "~> 0.54.3"},
      {:slack_elixir, "~> 1.2"}
    ]
  end
end
