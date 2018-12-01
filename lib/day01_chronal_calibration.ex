defmodule ChronalCalibration do

  def from_file(file) do
    File.stream!(file)
    |> Enum.join
    |> ChronalCalibration.of
  end

  def of(calibrations) do
    calibrations
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum
  end
end
