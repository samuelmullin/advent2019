defmodule Advent do
  @moduledoc """
  Documentation for Advent.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Advent.hello()
      :world

  """
  def day1() do
    IO.puts("Calculating total fuel needed for modules...")
    IO.puts("Total Fuel Needed: #{Advent.FuelCounterUpper.run()}")
  end
end
