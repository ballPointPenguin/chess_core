# credo:disable-for-this-file Credo.Check.Readability.Specs
# credo:disable-for-this-file Credo.Check.Warning.MixEnv
defmodule ChessCore.MixProject do
  @moduledoc false
  use Mix.Project

  def project do
    [
      app: :chess_core,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:binbo, "~> 4.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:ratatouille, "~> 0.5.1"},
      {:sobelow, "~> 0.8", only: :dev}
    ]
  end
end
