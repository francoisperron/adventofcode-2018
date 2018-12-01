defmodule ChronalCalibrationTest do
  use ExUnit.Case

  describe "part 1" do
    test "calibrates using one calibration" do
      assert ChronalCalibration.apply("+1") == 1
      assert ChronalCalibration.apply("-1") == -1
    end

    test "calibrates with multiple calibrations" do
      assert ChronalCalibration.apply("+1\n-4") == -3
    end

    test "solves it" do
      assert ChronalCalibration.read("lib/day01_data") |> ChronalCalibration.apply() === 459
    end
  end

  describe "part 2" do
    test "checks if a frequency is repeated" do
      assert ChronalCalibration.is_repeated(2, [2, 1]) === true
      assert ChronalCalibration.is_repeated(3, [2, 1]) === false
    end

    test "calculates next frequency from last frequency" do
      assert ChronalCalibration.next_frequency(3, [0]) === 3
      assert ChronalCalibration.next_frequency(5, [4, 3, 0]) === 9
    end

    test "finds first repeated frequency" do
      assert ChronalCalibration.repeated("+1\n-1") === 0
      assert ChronalCalibration.repeated("3\n+3\n+4\n-2\n-4") === 10
      assert ChronalCalibration.repeated("-6\n+3\n+8\n+5\n-6") === 5
    end

    #    too long :(
    #    test "solves it" do
    #      assert ChronalCalibration.read("lib/day01_data") |> ChronalCalibration.repeated === 65474
    #    end
  end
end
