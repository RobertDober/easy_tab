defmodule Support.FixtureHelper do

  def fixture_path(segments)
  def fixture_path(segments) when is_list(segments) do
    Path.join(~W[test fixtures] ++ segments)
  end
  def fixture_path(segments) do
    fixture_path([segments])
  end

  def read_fixture_file(segments) do
    segments
    |> fixture_path()
    |> ExAequo.File.readlines
  end


end
# SPDX-License-Identifier: Apache-2.0
