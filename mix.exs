defmodule App.MixProject do
  use Mix.Project

  def project do
    [
      app: :app,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {App.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:lenra_api, "~> 0.2.2"},
      # {:lenra_api, path: "../app-lib-elixir"},
      {:lenra_components, "~> 0.1.0"},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false}
    ]
  end
end
