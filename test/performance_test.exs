defmodule ExMaglev.Performance.Test do
  use ExMaglev.Case, async: false

  describe "performance checks" do
    test "basic check", context do
      nodes = [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday"
      ]

      {:ok, ref} = ExMaglev.new(nodes)

      w =
        :perftest.comprehensive(10_000_000, fn ->
          {:ok, _} = ExMaglev.hash(ref, "#{inspect(self())}")
        end)

      assert w |> Enum.all?(&(&1 >= 500_000))

      :ok
    end
  end
end
