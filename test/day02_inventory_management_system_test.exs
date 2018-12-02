defmodule InventoryManagementSystemTest do
  use ExUnit.Case

  describe "part 1" do
    test "finds duplicated letters in ids" do
      assert InventoryManagementSystem.has_letters_appearing(2, "abbcde") === true
      assert InventoryManagementSystem.has_letters_appearing(3, "abbcde") === false
    end

    test "solves it" do
      checksum =
        "day02_data"
        |> DataFile.read_lines
        |> InventoryManagementSystem.checksum

      assert checksum === 7221
    end
  end
end