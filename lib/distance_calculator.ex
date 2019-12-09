defmodule Advent.DistanceCalculator do

  def problem1() do
    input = get_input()
    run_wires(input)
    |> find_intersections()
    |> Enum.map(fn location -> calculate_manhattan_distance(location) end)
    |> Enum.min()
  end

  def problem2() do
    input = get_input()
    locations = run_wires(input)

    find_intersections(locations)
    |> IO.inspect()
    |> Enum.map(fn intersection -> calculate_total_steps(intersection, locations) end)
    |> Enum.min()
  end

  def calculate_manhattan_distance(location) do
    {x, y} = location |> split_location()

    abs(x) + abs(y)
  end

  def calculate_total_steps(intersection, locations) do
    steps1 = locations |> Enum.at(0) |> Map.get(intersection)
    steps2 = locations |> Enum.at(1) |> Map.get(intersection)
    
    steps1 + steps2
  end

  def find_intersections(locations) do
     location1 = Enum.at(locations, 0) |> Map.keys() |> MapSet.new()
     location2 = Enum.at(locations, 1) |> Map.keys() |> MapSet.new()

     MapSet.intersection(location1, location2)
  end

  def run_wires(input) do
    input
    |> Enum.map(fn wire_instructions -> run_wire(wire_instructions, %{loc_x: 0, loc_y: 0, locations: %{}, total_steps: 0}) end)
  end

  def run_wire(wire_instructions, state) do
    wire_instructions
    |> String.split(",")
    |> process_instructions(state)
  end

  def process_instructions(instructions, state) do
    %{locations: locations} = instructions
    |> Enum.reduce(state, fn instruction, state -> process_instruction(instruction, state) end)

    locations
  end

  def process_instruction(instruction, %{locations: locations} = state) do
    {direction, distance} = split_instruction(instruction)
    {loc_x, loc_y, total_steps, new_locations} = update_location(direction, distance, state)

    locations = Map.merge(locations, new_locations)

    state
    |> Map.put(:locations, locations)
    |> Map.put(:loc_x, loc_x)
    |> Map.put(:loc_y, loc_y)
    |> Map.put(:total_steps, total_steps)
  end

  def update_location("U", distance, %{loc_x: loc_x, loc_y: loc_y, total_steps: total_steps}) do
    new_locations = for steps <- 1..distance, into: %{}, do: {"#{loc_x},#{loc_y + steps}", total_steps + steps}
    {loc_x, loc_y + distance, total_steps + distance, new_locations}
  end

    def update_location("D", distance, %{loc_x: loc_x, loc_y: loc_y, total_steps: total_steps}) do
    new_locations = for steps <- 1..distance, into: %{}, do: {"#{loc_x},#{loc_y - steps}", total_steps + steps}
    {loc_x, loc_y - distance, total_steps + distance, new_locations}
  end

  def update_location("R", distance, %{loc_x: loc_x, loc_y: loc_y, total_steps: total_steps}) do
    new_locations = for steps <- 1..distance, into: %{}, do: {"#{loc_x + steps},#{loc_y}", total_steps + steps}
    {loc_x + distance, loc_y, total_steps + distance, new_locations}
  end

    def update_location("L", distance, %{loc_x: loc_x, loc_y: loc_y, total_steps: total_steps}) do
    new_locations = for steps <- 1..distance, into: %{}, do: {"#{loc_x - steps},#{loc_y}", total_steps + steps}
    {loc_x - distance, loc_y, total_steps + distance, new_locations}
  end
  
  def split_instruction(instruction) do
    [direction | distance] = instruction |> String.to_charlist()
    {[direction] |> to_string, distance |> to_string |> String.to_integer()}
  end

  def split_location(location) do
    location_parts = String.split(location, ",")
    {
      location_parts |> Enum.at(0) |> String.to_integer(),
      location_parts |> Enum.at(1) |> String.to_integer()
    }
  end

  def get_input() do
    File.read!("./priv/day3_input")
    |> String.split("\n")
  end

end