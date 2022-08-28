defmodule Test.Functional.ParseTest do
  use Support.AcceptanceTestCase

  describe "csv output" do
    test "one cell" do
      {:ok, result} = Tab.parse(%{}, ["hello"])
      assert result = [ ~s{"hello"} ]
    end
    test "two cells" do
      {:ok, result} = Tab.parse(%{}, ["hello", "world"])
      assert result = [ ~s{"hello","world"} ]
    end
    test "two lines" do
      {:ok, result} = Tab.parse(%{}, ["hello", "world", "---", "new"])
      assert result = [ ~s{"hello","world"}, ~s{"new"} ]
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
