defmodule Claim do
  defstruct [:id, :area]

  def parse(claim) do
    [id, x, y, dx, dy] =
      claim
      |> String.split(~r/[\s+:x,@#]/, trim: true)
      |> Enum.map(&String.to_integer/1)

    area = for cx <- Range.new(x, x + dx - 1), cy <- Range.new(y, y + dy - 1), do: {cx, cy}

    %Claim{id: id, area: area}
  end
end
