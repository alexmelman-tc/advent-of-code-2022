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

  def parse_input(input_str) do
    input_str
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [a, x] -> [convert_value(a), convert_value(x)] end)
  end

  def start do
    read_input_file()
    |> parse_input
    |> Enum.reduce(0, fn
      [a, x], acc when a == x -> acc + x + 3
      [a, x], acc when a == x - 1 or (a == 3 and x == 1) -> acc + x + 6
      [a, x], acc -> acc + x
    end)
  end
end
