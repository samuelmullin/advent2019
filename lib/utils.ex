defmodule Advent.Utils do
  def drop_last_element_of_list(list), do: list |> Enum.reverse() |> tl() |> Enum.reverse()
end