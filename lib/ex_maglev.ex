defmodule ExMaglev do
  @moduledoc """
  ExMaglev - wrapper for Maglev hash algorithm
  """

  alias :erlang, as: Erlang

  @version Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :ex_maglev,
    crate: "maglev",
    base_url: "https://github.com/Vonmo/ex_maglev/releases/download/v#{@version}",
    nif_versions: ["2.16", "2.17"],
    targets: ~w(
      aarch64-apple-darwin
      x86_64-apple-darwin

      aarch64-unknown-linux-musl
      x86_64-unknown-linux-gnu
      x86_64-unknown-linux-musl

      x86_64-pc-windows-msvc
    ),
    force_build:
      String.downcase(System.get_env("FORCE_BUILD_MAGLEV", "nope")) in ["1", "true", "yes"],
    version: @version

  def lxcode, do: Erlang.nif_error(:nif_not_loaded)
  def new(nodes), do: new(nodes, 701)
  def new(_nodes, _capacity), do: Erlang.nif_error(:nif_not_loaded)
  def get_capacity(_ref), do: Erlang.nif_error(:nif_not_loaded)
  def get_nodes(_ref), do: Erlang.nif_error(:nif_not_loaded)
  def hash(_ref, _term), do: Erlang.nif_error(:nif_not_loaded)
end
