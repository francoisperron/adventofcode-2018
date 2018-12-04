defmodule NoMatterHowYouSliceItTest do
  use ExUnit.Case

  describe "part 1" do
    test "parses a claim" do
      assert Claim.parse("#123 @ 3,2: 2x2") === %Claim{
               id: 123,
               area: [{3, 2}, {3, 3}, {4, 2}, {4, 3}]
             }
    end

    test "counts number of squares overlapping" do
      data = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

      assert NoMatterHowYouSliceIt.overlapping(data) === 4
    end

    test "solves it" do
      data = DataFile.read_lines("day03/data")

      assert NoMatterHowYouSliceIt.overlapping(data) === 105_231
    end
  end

  describe "part2" do
    test "finds claim not overlapping" do
      data = ["#1 @ 1,3: 4x4", "#2 @ 3,1: 4x4", "#3 @ 5,5: 2x2"]

      assert NoMatterHowYouSliceIt.not_overlapping_claim_id(data) === 3
    end

    test "solves it" do
      data = DataFile.read_lines("day03/data")

      assert NoMatterHowYouSliceIt.not_overlapping_claim_id(data) === 164
    end
  end
end
