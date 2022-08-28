defmodule EasyTab.Cli do
  alias EasyTab.Tab

  @moduledoc ~S"""
  The escript entry to call `easy_tab` from the command line
  """

  def main(argv) do
    switches = [
      help: :boolean,
      version: :boolean,
    ]
    aliases = [
      h: :help,
      v: :version
    ]

    case OptionParser.parse(argv, strict: switches, aliases: aliases) do
      { _, _, [_|_]=errors} ->  _croak(errors)
      { [ {:help, true} ], _, _ } -> _help()
      { [ {:version, true} ], _, _ } -> _version()
      { options, [ file ],  _ }  -> _run(options, File.stream!(file))
      { options, [ ],           _ }  -> _run(options, :stdio)
    end
  end

  defp _run(options, stream) do
    case Tab.parse(options, stream) do
      {:error, errors} -> IO.puts(:stderr, errors |> Enum.join("\n"))
      {:ok, result} -> IO.puts(result |> Enum.join("\n"))
    end
  end

  defp _croak(errors) do
    errors
    |> Enum.each(&_croak_error/1)
  end

  defp _croak_error(option_value)
  defp _croak_error({option, nil}) do
    IO.puts(:stderr, "boolean option #{option} is undefined")
  end

  defp _help do
    IO.puts(:stderr, "help's coming soon, hang in there")
  end

  defp _version do
    with {:ok, vsn} <- :application.get_key(:easy_tab, :vsn) do
      IO.puts(:stderr, to_string(vsn))
    end
  end
end
# SPDX-License-Identifier: Apache-2.0
