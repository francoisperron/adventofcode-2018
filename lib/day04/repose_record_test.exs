defmodule ReposeRecordTest do
  use ExUnit.Case

  defp test_data do
    [
      "[1518-11-01 00:05] falls asleep",
      "[1518-11-01 00:25] wakes up",
      "[1518-11-01 00:30] falls asleep",
      "[1518-11-01 00:55] wakes up",
      "[1518-11-01 23:58] Guard #99 begins shift",
      "[1518-11-02 00:40] falls asleep",
      "[1518-11-02 00:50] wakes up",
      "[1518-11-03 00:05] Guard #10 begins shift",
      "[1518-11-03 00:24] falls asleep",
      "[1518-11-03 00:29] wakes up",
      "[1518-11-04 00:02] Guard #99 begins shift",
      "[1518-11-04 00:36] falls asleep",
      "[1518-11-04 00:46] wakes up",
      "[1518-11-05 00:03] Guard #99 begins shift",
      "[1518-11-05 00:45] falls asleep",
      "[1518-11-05 00:55] wakes up",
      "[1518-11-01 00:00] Guard #10 begins shift"
    ]
  end

  describe "part 1" do
    test "parses a record" do
      assert MyRecord.parse("[1518-03-30 00:57] wakes up") ===
               %MyRecord{timestamp: ~N[1518-03-30 00:57:00], note: "wakes up"}
    end

    test "orders records by date" do
      records = [
        "[1518-04-15 23:56] Guard #2213 begins shift",
        "[1518-10-31 00:36] wakes up",
        "[1518-03-30 00:57] wakes up"
      ]

      assert ReposeRecord.order(records) ===
               [
                 %MyRecord{timestamp: ~N[1518-03-30 00:57:00], note: "wakes up"},
                 %MyRecord{timestamp: ~N[1518-04-15 23:56:00], note: "Guard #2213 begins shift"},
                 %MyRecord{timestamp: ~N[1518-10-31 00:36:00], note: "wakes up"}
               ]
    end


    test "finds guard asleep the most" do
      assert ReposeRecord.find_guard_asleep_the_most(test_data()) === 10
    end

    test "finds minute most asleep for a guard" do
      assert ReposeRecord.find_minute_most_asleep_for_guard("10", test_data()) === 24
    end

    test "solves it" do
      data = DataFile.read_lines("day04/data")

      assert ReposeRecord.find_guard_asleep_the_most(data) === 1777
      assert ReposeRecord.find_minute_most_asleep_for_guard("1777", data) === 48
      assert 1777 * 48 === 85296
    end
  end

  describe "part 2" do
    test "finds guard asleep the most on the same minute" do
      assert ReposeRecord.find_guard_asleep_the_most_on_the_same_minute(test_data()) === 4455
    end

    test "solves it" do
      data = DataFile.read_lines("day04/data")

      assert ReposeRecord.find_guard_asleep_the_most_on_the_same_minute(data) === 58559
    end
  end

end
