defmodule Day03.ItemPriority do
  def from_char(item) do
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
end
