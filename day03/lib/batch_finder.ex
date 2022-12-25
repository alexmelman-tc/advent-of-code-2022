defmodule Day03.BatchFinder do
  alias Day03.ItemPriority, as: ItemPriority

  def parse_input(input_str) do
    input_str
    |> String.split("\n", trim: true)
  end

  def read_input_file(filename) do
    {:ok, body} = File.read(filename)
    body
  end

  def group_sets(rucksacks) do
    Enum.chunk_every(rucksacks, 3)
  end

  def find_common_chars_in_strings([str1 | str2]) when length(str2) == 1 do
    with [str2 | _] <- str2 do
      Enum.filter(String.codepoints(str1), &(String.contains?(str2, &1)))
      |> Enum.uniq
    end
  end

  def find_common_chars_in_strings([str1 | tail]) do
    with [str2 | _] <- tail do
      Enum.filter(
        find_common_chars_in_strings([str1, str2]),
        fn x -> Enum.member?(find_common_chars_in_strings(tail), x) end
      )
    end
  end

  def find_common_item_in_set(rucksacks) do
    find_common_chars_in_strings(rucksacks)
  end

  def start(input_filename \\ "input/full") do
    read_input_file(input_filename)
    |> parse_input
    |> group_sets
    |> Enum.flat_map(&find_common_item_in_set/1)
    |> Enum.map(&ItemPriority.from_char/1)
    |> Enum.sum
  end
end
