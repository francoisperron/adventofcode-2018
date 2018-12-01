defmodule ChronalCalibrationTest do
  use ExUnit.Case

  test "calibrates one frequency" do
    assert ChronalCalibration.of("+1") == 1
    assert ChronalCalibration.of("-1") == -1
  end

  test "calibrates multiple frequencies" do
    assert ChronalCalibration.of("+1\n-4") == -3
  end

  test "calibrates using part1 data" do
    assert ChronalCalibration.from_file("lib/day01_data") === 459
  end
end
