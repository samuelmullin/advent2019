defmodule Advent.FuelCounterUpper do

    def recursive_calculate_module_required_fuel(mass, total) when mass < 8, do: total
    def recursive_calculate_module_required_fuel(mass, total) do 
      new_fuel = calculate_module_required_fuel(mass)
      recursive_calculate_module_required_fuel(new_fuel, total + new_fuel)
    end

    def calculate_module_required_fuel(mass), do: Integer.floor_div(mass, 3) - 2
    
    def calculate_total_required_fuel(module_masses) do
      module_masses
      |> Enum.reduce(0, fn module, total -> total + recursive_calculate_module_required_fuel(module, 0) end)
    end

    def get_input() do
      File.read!("./priv/day1_input")
      |> String.split("\n")
      |> Advent.Utils.drop_last_element_of_list()
      |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
    end

    def run() do
      get_input()
      |> calculate_total_required_fuel()
    end
end