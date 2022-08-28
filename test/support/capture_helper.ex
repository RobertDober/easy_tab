defmodule Support.CaptureHelper do
  @moduledoc false

  import ExUnit.CaptureIO

  def capture_stdout(fun) do
    capture_io(fun)
    |> String.trim_trailing("\n")
  end

  def capture_stderr(fun) do
    capture_io(:stderr, fun)
    |> String.trim_trailing("\n")
  end
end
# SPDX-License-Identifier: Apache-2.0
