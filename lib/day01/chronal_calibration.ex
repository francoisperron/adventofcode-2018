defmodule ChronalCalibration do
  def apply(calibrations) do
    calibrations
    |> to_int
    |> Enum.sum()
  end

  def repeated(calibrations) do
    calibrations
    |> to_int
    |> Stream.cycle()
    |> Enum.reduce_while([0], &find_repeated_frequency/2)
  end

  def to_int(calibrations) do
    calibrations
    |> Enum.map(&String.to_integer/1)
  end

  def find_repeated_frequency(calibration, frequencies) do
    frequency = next_frequency(calibration, frequencies)

    if is_repeated(frequency, frequencies) do
      {:halt, frequency}
    else
      {:cont, [frequency | frequencies]}
    end
  end

  def next_frequency(calibration, frequencies) do
    List.first(frequencies) + calibration
  end

  def is_repeated(frequency, frequencies) do
    Enum.member?(frequencies, frequency)
  end
end
