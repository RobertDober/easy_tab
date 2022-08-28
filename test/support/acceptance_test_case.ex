defmodule Support.AcceptanceTestCase do

  defmacro __using__(_options) do
    quote do
      use ExUnit.Case

      alias EasyTab.Tab

      import ExUnit.CaptureIO
      import Support.FixtureHelper
      import Support.CaptureHelper
    end
  end

end
# SPDX-License-Identifier: Apache-2.0
