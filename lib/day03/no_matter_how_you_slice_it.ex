defmodule NoMatterHowYouSliceIt do
  def overlapping(claims) do
    claims
    |> Enum.map(&Claim.parse/1)
    |> Enum.map(fn c -> c.area end)
    |> List.flatten()
    |> Enum.reduce(%{}, fn square, result -> Map.update(result, square, 1, &(&1 + 1)) end)
    |> Enum.count(fn {_, count} -> count > 1 end)
  end

  def not_overlapping_claim_id(claims) do
    overlapping =
      claims
      |> Enum.map(&Claim.parse/1)
      |> Enum.map(fn c -> c.area end)
      |> List.flatten()
      |> Enum.reduce(%{}, fn square, result -> Map.update(result, square, 1, &(&1 + 1)) end)
      |> Enum.filter(fn {_, count} -> count > 1 end)
      |> Enum.map(&elem(&1, 0))
      |> MapSet.new()

    claims
    |> Enum.map(&Claim.parse/1)
    |> Enum.filter(&with_no_overlapping_square(&1, overlapping))
    |> Enum.map(fn c -> c.id end)
    |> List.first()
  end

  def with_no_overlapping_square(claim, overlapping) do
    Enum.count(MapSet.intersection(MapSet.new(claim.area), overlapping)) == 0
  end
end
