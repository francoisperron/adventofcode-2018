defmodule AlchemicalReduction do
  def unit_remaining_after_scan(polymer) do
    polymer
    |> String.graphemes()
    |> scan
    |> Enum.count()
  end

  def shortest_unit_remaining_after_scan(polymer) do
    (for u <- ?a..?z, do: << u :: utf8 >>)
    |> Enum.map(&react_without_unit_type(polymer, &1))
    |> Enum.sort()
    |> List.first()
  end

  def react_without_unit_type(polymer, unit_type) do
    polymer
    |> String.graphemes()
    |> Enum.filter(fn u -> String.downcase(u) != unit_type end)
    |> scan
    |> Enum.count()
  end

  def scan(polymer) do
    Enum.reduce(polymer, [], fn
      first_unit, [] -> [first_unit]
      unit, [previous_unit | remaining_polymer] -> reacts(unit, previous_unit, remaining_polymer)
    end)
  end

  def reacts(unit, previous_unit, polymer) do
    if is_reacting(unit, previous_unit) do
      polymer
    else
      [unit, previous_unit | polymer]
    end
  end

  def is_reacting(unit1, unit2) do
    unit1 != unit2 && String.downcase(unit1) == String.downcase(unit2)
  end

end

