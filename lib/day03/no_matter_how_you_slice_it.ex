defmodule NoMatterHowYouSliceIt do
  def overlapping(claims) do
    claims
    |> Enum.map(&Claim.parse/1)
    |> Enum.map(fn c -> c.area end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, &(&1 + 1)) end)
    |> Map.values()
    |> Enum.count(fn o -> o > 1 end)
  end
end
