defmodule EasyTab.MixProject do
  use Mix.Project

  @version "0.1.0"
  @url "https://github.com/robertdober/easy_tab"

  @description """
  Convert text into csv or html tables

  Convigurable, annotable
  """
  def project do
    [
      aliases: [
        docs: &build_docs/1,
        check: ["dialyzer", "test"],
        all: ["xtra", "docs"],
      ],
      app: :easy_tab,
      deps: deps(),
      description: @description,
      elixir: "~> 1.13",
      elixirc_paths: elixirc_paths(Mix.env()),
      escript: [main_module: EasyTab.Cli],
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      applications: []
      # extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:csv, "~> 2.4.1"},
      {:ex_aequo, "~> 0.4.0"},
      {:excoveralls, "~> 0.14.6", only: [:test]},
      {:extractly, "~>0.5.3", only: [:dev]},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  @prerequisites """
  run `mix escript.install hex ex_doc` and adjust `PATH` accordingly
  """
  @module "EasyTab"
  defp build_docs(_) do
    Mix.Task.run("compile")
    ex_doc = Path.join(Mix.path_for(:escripts), "ex_doc")
    Mix.shell().info("Using escript: #{ex_doc} to build the docs")

    unless File.exists?(ex_doc) do
      raise "cannot build docs because escript for ex_doc is not installed, make sure to \n#{
              @prerequisites
            }"
    end

    args = [@module, @version, Mix.Project.compile_path()]
    opts = ~w[--main #{@module} --source-ref v#{@version} --source-url #{@url}]

    Mix.shell().info("Running: #{ex_doc} #{inspect(args ++ opts)}")
    System.cmd(ex_doc, args ++ opts)
    Mix.shell().info("Docs built successfully")
  end


  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      files: [
        "lib",
        "mix.exs",
        "README.md"
      ],
      maintainers: [
        "Robert Dober <robert.dober@gmail.com>"
      ],
      licenses: [
        "Apache 2 (see the file LICENSE for details)"
      ],
      links: %{
        "GitHub" => "https://github.com/robertdober/easy_tab"
      }
    ]
  end
end
# SPDX-License-Identifier: Apache-2.0
