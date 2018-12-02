defmodule DataFile do
  def read_lines(file) do
    File.stream!("lib/#{file}")
    |> Enum.join()
    |> String.split("\n")
  end
end
