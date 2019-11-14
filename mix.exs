defmodule Imaginary.MixProject do
  @github_url "https://github.com/olaf-cichocki/Imaginary"
  use Mix.Project

  def project do
    [
      app: :imaginary,
      name: "Imaginary",
      description: description(),
      version: "0.0.1",
      elixir: "~> 1.6",
      source_url: @github_url,
      homepage_url: @github_url,
      package: package(),
      files: ~w(mix.exs lib LICENSE.md README.md CHANGELOG.md),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp description do
    """
    Work In progress - library to handle Cloudinary in Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md"],
      maintainers: ["Olaf Cichocki"],
      licenses: ["MIT"],
      links: %{"GitHub" => @github_url, "Docs" => "https://hexdocs.pm/imaginary/"}
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
      {:ex_doc, "~> 0.21.2", only: :dev, runtime: false},
      {:junit_formatter, "~> 2.1", only: :test},
      {:credo, "~> 0.8", only: [:dev, :test]},
      {:excoveralls, "~> 0.8", only: :test}
      # {:earmark, "~> 1.4", only: :dev}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
