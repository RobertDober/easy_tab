defmodule EasyTab.Converter do
  @moduledoc false

  def chomp(string) do
    string
    |> String.trim_trailing("\n")
  end

  def to_csv(strings) do
    [strings]
    |> CSV.encode(delimiter: "")
    |> Enum.to_list
  end
end
# SPDX-License-Identifier: Apache-2.0
