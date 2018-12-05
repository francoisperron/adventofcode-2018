defmodule MyRecord do
  defstruct [:timestamp, :note]

  def parse(data) do
    [timestamp_string, note] = data
                               |> String.split(~r/[+x,\[\]]/, trim: true)

    {:ok, timestamp} = NaiveDateTime.from_iso8601("#{timestamp_string}:00")

    %MyRecord{timestamp: timestamp, note: String.trim(note)}
  end
end
