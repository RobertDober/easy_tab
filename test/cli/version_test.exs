defmodule Test.Cli.VersionTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "version parameter" do
    test "with -h" do
      result = capture_io(:stderr, fn ->
        EasyTab.Cli.main(~W[-v])
      end)
      assert String.trim_trailing(result, "\n") == version()
    end

    test "with --version" do
      result = capture_io(:stderr, fn ->
        EasyTab.Cli.main(~W[--version])
      end)
      assert String.trim_trailing(result, "\n") == version()
    end
  end

  def version do
    with {:ok, vsn} <- :application.get_key(:easy_tab, :vsn) do
      to_string(vsn)
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
