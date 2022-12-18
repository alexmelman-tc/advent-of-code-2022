defmodule Day03.RucksackOrganizer do
  @moduledoc """
  Documentation for `Day03`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day03.hello()
      :world

  """

  def parse_input(input_str) do
    input_str
    |> String.split("\n", trim: true)
  end

  def read_input_file(filename) do
    {:ok, body} = File.read(filename)
    body
  end

  def find_items_in_both_compartments(rucksack) do
    len = div(String.length(rucksack), 2)

    with {compartment1, compartment2} <- String.split_at(rucksack, len) do
      compartment1
      |> String.graphemes
      |> Enum.uniq
      |> Enum.filter(fn x -> x in String.graphemes(compartment2) end)
    end
  end

  def item_priority(item) do
    with code <- :binary.first(item) do
      case string_class(item) do
        :upper -> code - 38
        :lower -> code - 96
      end
    end
  end

  def string_class(str) do
    cond do
      uppercase?(str) -> :upper
      lowercase?(str) -> :lower
    end
  end

  def uppercase?(str) do
    String.match?(str, ~r/^[[:upper:]]$/)
  end

  def lowercase?(str) do
    String.match?(str, ~r/^[[:lower:]]$/)
  end

  def start(input_filename \\ "input/full") do
    read_input_file(input_filename)
    |> parse_input
    |> Enum.flat_map(&find_items_in_both_compartments/1)
    |> Enum.map(&item_priority/1)
    |> Enum.sum
  end
end
