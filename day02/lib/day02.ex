defmodule Day02.StrategyGuide do
  def read_input_file do
    {:ok, body} = File.read("input")
    body
  end

  def convert_value(value) do
    case value do
      x when x in ["A", "X"] -> 1
      x when x in ["B", "Y"] -> 2
      x when x in ["C", "Z"] -> 3
    end
  end

  def convert_input_values(parsed_input) do
    Enum.map(parsed_input, fn [a, x] -> [convert_value(a), convert_value(x)] end)
  end

  def throw_rounds(parsed_input) do
    Enum.map(parsed_input, fn
      [a, 1] -> [a, throw_round(a, :lose)]
      [a, 2] -> [a, throw_round(a, :draw)]
      [a, 3] -> [a, throw_round(a, :win)]
    end)
  end

  def throw_round(opp, round_end) do
    case round_end do
      :win -> if opp < 3, do: opp + 1, else: 1
      :lose -> if opp > 1, do: opp - 1, else: 3
      :draw -> opp
    end
  end

  def parse_input(input_str) do
    input_str
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
  end

  def start_1 do
    read_input_file()
    |> parse_input
    |> convert_input_values
    |> Enum.reduce(0, fn
      [a, x], acc when a == x -> acc + x + 3
      [a, x], acc when a == x - 1 or (a == 3 and x == 1) -> acc + x + 6
      [_, x], acc -> acc + x
    end)
  end

  def start_2 do
    read_input_file()
    |> parse_input
    |> convert_input_values
    |> throw_rounds
    |> Enum.reduce(0, fn
      [a, x], acc when a == x -> acc + x + 3
      [a, x], acc when a == x - 1 or (a == 3 and x == 1) -> acc + x + 6
      [_, x], acc -> acc + x
    end)
  end
end
