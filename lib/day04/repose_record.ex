defmodule ReposeRecord do
  def order(data) do
    data
    |> Enum.map(&MyRecord.parse/1)
    |> Enum.sort(&(NaiveDateTime.compare(&1.timestamp, &2.timestamp) == :lt))
  end

  def find_guard_asleep_the_most(data) do
    records = data
              |> order
              |> Enum.reduce(
                   %{guard: 0, asleep: 0, guards: %{}},
                   fn record, acc ->
                     guard =
                       case String.contains?(record.note, "Guard") do
                         true ->
                           String.split(record.note, ~r/[+x,# ]/, trim: true)
                           |> Enum.fetch(1)
                           |> elem(1)
                         _ -> acc.guard
                       end

                     asleep =
                       case String.contains?(record.note, "falls") do
                         true -> record.timestamp
                         _ -> nil
                       end

                     asleep_time =
                       case String.contains?(record.note, "wakes") do
                         true -> NaiveDateTime.diff(record.timestamp, acc.asleep, :second) / 60
                         _ -> 0
                       end

                     %{guard: guard, asleep: asleep, guards: Map.update(acc.guards, guard, 0, &(&1 + asleep_time))}
                   end
                 )

    records.guards
    |> Enum.sort_by(&(elem(&1, 1)))
    |> List.last()
    |> elem(0)
    |> String.to_integer()
  end

  def find_minute_most_asleep_for_guard(das_guard, data) do
    records = data
              |> order
              |> Enum.reduce(
                   %{guard: 0, minutes: %{}},
                   fn record, acc ->
                     guard =
                       case String.contains?(record.note, "Guard") do
                         true ->
                           String.split(record.note, ~r/[+x,# ]/, trim: true)
                           |> Enum.fetch(1)
                           |> elem(1)
                         _ -> acc.guard
                       end

                     asleep =
                       case String.contains?(record.note, "falls") do
                         true -> record.timestamp
                         _ -> nil
                       end

                     minutes =
                       case String.contains?(record.note, "wakes") do
                         true ->
                           Range.new(record.timestamp.minute - 1, acc.asleep.minute)
                           |> Enum.to_list()
                         _ -> []
                       end

                     %{guard: guard, asleep: asleep, minutes: Map.update(acc.minutes, guard, [0], &(&1 ++ minutes))}
                   end
                 )

      records.minutes[das_guard]
      |> Enum.reduce(%{}, fn square, result -> Map.update(result, square, 1, &(&1 + 1)) end)
      |> Enum.sort_by(&(elem(&1, 1)))
      |> Enum.reverse()
      |> List.first()
      |> elem(0)
  end
end