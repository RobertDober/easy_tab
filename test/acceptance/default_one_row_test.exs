defmodule Test.Acceptance.DefaultOneRowTest do
  use Support.AcceptanceTestCase

  describe "csv output" do
    test "default" do
      expected_result = [
        ~s{"cell 1","cell 2","cell 3"}
      ] |> Enum.join("\n")
      result = capture_stdout(fn ->
        EasyTab.Cli.main([fixture_path("default_one_row.txt")])
      end)

      assert result == expected_result
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
