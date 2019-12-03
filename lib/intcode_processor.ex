defmodule Advent.IntcodeProcessor do

  def problem1() do
    get_input()
    |> process_opcode_list()
  end

  def problem2(noun \\ 0, verb \\ 0) do
    with input    <- get_input(noun, verb),
         output   <- process_opcode_list(input),
         19690720 <- Enum.at(output, 0)
    do
        {noun, verb}
    else
      _ -> 
       {noun, verb} = case noun == 99 do
          false -> {noun + 1, verb}
          true  -> {0, verb + 1}
        end
        problem2(noun, verb)
    end
  end

  def process_opcode_list(opcode_list, index \\ 0) do
    opcode_list
    |> Enum.slice(index, 4)
    |> process_opcode(opcode_list, index)
  end

  def extract_values(opcode_list, index1, index2) do
    {opcode_list |> Enum.at(index1), opcode_list |> Enum.at(index2)}
  end

  def process_opcode([1 | [in_index1, in_index2, out_index]], opcode_list, index) do
    {value1, value2} = extract_values(opcode_list, in_index1, in_index2)
    opcode_list = opcode_list |> List.replace_at(out_index, value1 + value2)

    process_opcode_list(opcode_list, index + 4)
  end

  def process_opcode([2 | [in_index1, in_index2, out_index]], opcode_list, index) do
    {value1, value2} = extract_values(opcode_list, in_index1, in_index2)
    opcode_list = opcode_list |> List.replace_at(out_index, value1 * value2)

    process_opcode_list(opcode_list, index + 4)
  end

  def process_opcode([99 | _input], opcode_list, _index), do: opcode_list

  def get_input(noun \\ 12, verb \\ 2) do
    File.read!("./priv/day2_input")
    |> String.split(",")
    |> Enum.map(fn x -> Integer.parse(x) |> elem(0) end)
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
  end

end