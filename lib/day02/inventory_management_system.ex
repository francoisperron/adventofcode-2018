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

  def closest_id(ids) do
    Enum.reduce_while(
      ids,
      nil,
      fn id1, _ ->
        diff = find_id_with_one_diff(id1, ids)
        if (elem(diff, 0) == 1) do
          {:halt, elem(diff, 1)}
        else
          {:cont, nil}
        end
      end
    )
  end

  def find_id_with_one_diff(id1, ids) do
    Enum.reduce(
      ids,
      {0, ""},
      fn id2, acc ->
        diff = count_diff(id1, id2)
        if (elem(diff, 0) == 1) do
          diff
        else
          acc
        end
      end
    )
  end

  def count_diff(s1, s2) do
    diff = String.myers_difference(s1, s2)

    count = diff
            |> Keyword.get_values(:ins)
            |> Enum.join()
            |> String.length()

    name = diff
           |> Keyword.get_values(:eq)
           |> Enum.join()

    {count, name}
  end

end
