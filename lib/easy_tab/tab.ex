defmodule EasyTab.Tab do
  alias EasyTab.Options
  import EasyTab.Converter

  @moduledoc false

  defstruct status: :ok, cells: [], errors: [], result: [], options: %{}

  def new(options) do
    struct(__MODULE__, options: Options.new(options))
  end

  def parse(options, stream) do
    case Enum.reduce(stream, new(options), &parse_line/2) do
      %__MODULE__{status: :open}=tab -> {:ok, parse_line("---", tab).result |> Enum.reverse}
      %__MODULE__{status: :ok, result: result} -> {:ok, result |> Enum.reverse}
      %__MODULE__{status: :error, errors: errors} -> {:error, errors |> Enum.reverse}
    end
  end

  @line_sep ~r[\A -{3,} \s* \z]x
  def parse_line(line, tab)
  def parse_line(line, %__MODULE__{}=tab) do
    cond do
      Regex.match?(@line_sep, line) -> _close_line(tab)
      true -> _add_cell(line, tab)
    end
  end

  defp _add_cell(line, %__MODULE__{cells: cells}=tab) do
    %{tab | status: :open, cells: [chomp(line) | cells]}
  end

  defp _close_line(%__MODULE__{cells: cells, result: result}=tab) do
    %{tab | status: _ok(tab.status), cells: [], result: [to_csv(Enum.reverse(cells)) | result]}
  end

  defp _ok(status)
  defp _ok(:error), do: :error
  defp _ok(_), do: :ok
end
# SPDX-License-Identifier: Apache-2.0
