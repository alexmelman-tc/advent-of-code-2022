defmodule Day03.RucksackOrganizer do
  alias Day03.ItemPriority, as: ItemPriority

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

  def start(input_filename \\ "input/full") do
    read_input_file(input_filename)
    |> parse_input
    |> Enum.flat_map(&find_items_in_both_compartments/1)
    |> Enum.map(&ItemPriority.from_char/1)
    |> Enum.sum
  end
end
