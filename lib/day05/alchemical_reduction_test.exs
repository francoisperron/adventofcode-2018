defmodule AlchemicalReductionTest do
  use ExUnit.Case

  describe "part 1" do
    test "detects same type and opposite polarity units" do
      assert AlchemicalReduction.is_reacting("a", "A") === true
      assert AlchemicalReduction.is_reacting("A", "a") === true
      assert AlchemicalReduction.is_reacting("A", "A") === false

      assert AlchemicalReduction.is_reacting("b", "a") === false
    end

    test "scans polymer for unit remaining" do
      assert AlchemicalReduction.unit_remaining_after_scan("aA") === 0
      assert AlchemicalReduction.unit_remaining_after_scan("dabAcCaCBAcCcaDA") === 10
    end

    test "solves it" do
      data = DataFile.read_lines("day05/data") |> List.first()

      assert AlchemicalReduction.unit_remaining_after_scan(data) === 11310
    end
  end

  describe "part 2" do

    test "reacts removing unit type from polymer" do
      assert AlchemicalReduction.react_without_unit_type("dabAcCaCBAcCcaDA", "a") === 6
      assert AlchemicalReduction.react_without_unit_type("daAcCaCAcCcaDA", "b") === 8
    end

    test "scans for shortest polymer" do
      assert AlchemicalReduction.shortest_unit_remaining_after_scan("dabAcCaCBAcCcaDA") === 4
    end

    test "solves it" do
      data = DataFile.read_lines("day05/data") |> List.first()

      assert AlchemicalReduction.shortest_unit_remaining_after_scan(data) === 6020
    end
  end
end
