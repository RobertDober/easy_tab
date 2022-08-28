defmodule EasyTab.Options do
  @moduledoc false

  defstruct col_sep: ",", quote_char: ~s{"}
  def new(options) do
    struct(__MODULE__, options)
  end

end
