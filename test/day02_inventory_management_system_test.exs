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

  describe "part 2" do
    test "count diff between two ids" do
      assert InventoryManagementSystem.count_diff("abcbe", "axcye") === {2, "ace" }
      assert InventoryManagementSystem.count_diff("fghij", "fguij") === {1,  "fgij"}
      assert InventoryManagementSystem.count_diff("abcde", "fghij") === {5,  ""}
      assert InventoryManagementSystem.count_diff("nkuagflethzwsijxrqvymbdpoq", "wkucgflathznsijqrevymbdpoq") === {6,  "kugflthzsijqvymbdpoq"}
    end

    test "solves example data" do
      id =
        ["abcde","fghij","klmno","pqrst","fguij","axcye","wvxyz"]
        |> InventoryManagementSystem.closest_id

      assert id === "fgij"
    end

    test "solves it" do
      id =
        "day02_data"
        |> DataFile.read_lines
        |> InventoryManagementSystem.closest_id

      assert id === "mkcdflathzwsvjxrevymbdpoq"
    end
  end
end