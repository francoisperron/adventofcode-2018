defmodule AlchemicalReductionTest do
  use ExUnit.Case

  test "detects same type and opposite polarity units" do
    assert AlchemicalReduction.is_reacting("a", "A") === true
    assert AlchemicalReduction.is_reacting("A", "a") === true
    assert AlchemicalReduction.is_reacting("A", "A") === false

    assert AlchemicalReduction.is_reacting("b", "a") === false
  end

  test "scans polymer" do
    assert AlchemicalReduction.scan("aA") === 0
    assert AlchemicalReduction.scan("dabAcCaCBAcCcaDA") === 10
  end

  test "solves it" do
    data = DataFile.read_lines("day05/data") |> List.first()

    assert AlchemicalReduction.scan(data) === 11310
  end
end
