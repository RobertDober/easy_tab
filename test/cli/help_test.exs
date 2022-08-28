defmodule Test.Cli.HelpTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "help parameter" do
    test "with -h" do
      result = capture_io(:stderr, fn ->
        EasyTab.Cli.main(~W[-h])
      end)
      assert Regex.match?(~r{help}, result)
    end
    test "with --help" do
      result = capture_io(:stderr, fn ->
        EasyTab.Cli.main(~W[--help])
      end)
      assert Regex.match?(~r{help}, result)
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
