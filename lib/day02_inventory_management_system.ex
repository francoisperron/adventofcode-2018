defmodule InventoryManagementSystem do
  def has_letters_appearing(count, id) do
    id
    |> String.graphemes()
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.member?(count)
  end


  def checksum(ids) do
    double = ids
             |> Enum.map(&has_letters_appearing(2, &1))
             |> Enum.count(fn x -> x == true end)

    triple = ids
             |> Enum.map(&has_letters_appearing(3, &1))
             |> Enum.count(fn x -> x == true end)

    double * triple
  end
end
