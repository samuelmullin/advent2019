defmodule Advent.Password do
  def problem1() do
    find_passwords(367479, 893698)
    |> Enum.count()
  end

  def find_passwords(range_start, range_end) do
    for password <- range_start..range_end, validate(password), do: password
  end
  
  def validate(password) do
    with true <- validate_length(password),
         true <- validate_double_digits(password),
         true <- validate_no_decrease(password)
    do
      true
    else
      _ -> false
    end
  end

  def validate_length(password) when password > 99999 and password < 1000000, do: true
  def validate_length(_password), do: false

  def validate_double_digits(password) do
    password_chars = password
    |> Integer.to_charlist()

    password_length = password_chars |> Enum.count()

    out = for index <- 0..(password_length - 2), double_digits?(password_chars, index), do: Enum.at(password_chars, index)
    
    out
    |> Enum.any?()
  end

  def double_digits?(password_chars, index) do
    val0 = Enum.at(password_chars, index - 1)
    val1 = Enum.at(password_chars, index)
    val2 = Enum.at(password_chars, index + 1)
    val3 = Enum.at(password_chars, index + 2)

    val1 == val2 and val2 != val3 and val0 != val1
  end

  def validate_no_decrease(password) do
   password_chars = password
    |> Integer.to_charlist()

    password_length = password_chars |> Enum.count()

    out = for index <- 0..(password_length - 2), no_decrease?(password_chars, index), do: true

    (out |> Enum.count()) == (password_chars |> Enum.count()) - 1
  end

  def no_decrease?(password_chars, index) do
    val1 = Enum.at(password_chars, index)
    val2 = Enum.at(password_chars, index + 1)

    #IO.puts("#{val1} <= #{val2}: #{val1 <= val2}")

    val1 <= val2
  end

end