defmodule Test.Cli.ErrorTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  describe "illegal parameters" do
    test "--yelp" do
      result = capture_io(:stderr, fn ->
        EasyTab.Cli.main(~W[--yelp])
      end) |> String.trim_trailing("\n")

      assert result == "boolean option --yelp is undefined"
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
