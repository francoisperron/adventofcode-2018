defmodule AlchemicalReduction do
  def scan(polymer) do
    polymer
    |> String.graphemes()
    |> react
    |> Enum.count()
  end

  def react(polymer) do
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

# skip first
# pour chaque char, si != et avant low char == low char
# remove avant et char
