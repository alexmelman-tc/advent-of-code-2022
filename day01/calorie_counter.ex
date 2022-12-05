defmodule CalorieCounter do
  def read_input_file(filename) do
    {:ok, body} = File.read(filename)
    body
  end

  def parse_input(input_str) do
    input_str
    |> String.split("\n\n", trim: true)
    |> Enum.map(&(String.split(&1, "\n", trim: true)))
    |> Enum.map(fn x -> Enum.map(x, &String.to_integer/1) end)
  end

  def sum_calories_per_elf(parsed_input) do
    parsed_input |> Enum.map(&Enum.sum/1)
  end

  def max_elf_calories(calories_sums) do
    Enum.max(calories_sums)
  end

  def sum_of_top_three_max_elf_calories(calories_sums) do
    Enum.sort(calories_sums, :desc)
    |> Enum.take(3)
    |> Enum.sum
  end

  def parse_and_sum_calories_per_elf(input_filename) do
    read_input_file(input_filename)
    |> parse_input
    |> sum_calories_per_elf
  end

  def find_elf_with_max_calories(input_filename \\ "input.csv") do
    answer = parse_and_sum_calories_per_elf(input_filename)
    |> max_elf_calories

    IO.puts(answer)
  end

  def find_sum_of_top_three_elves_with_max_calories(input_filename \\ "input.csv") do
    answer = parse_and_sum_calories_per_elf(input_filename)
    |> sum_of_top_three_max_elf_calories

    IO.puts(answer)
  end
end
