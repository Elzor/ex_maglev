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

Benchee.run(
  %{
    "maglev" => fn ->
      {:ok, _} = ExMaglev.hash(ref, "#{inspect(self())}")
    end,
    "phash2" => fn ->
      :lists.nth(:erlang.phash2("#{inspect(self())}", length(nodes) - 1) + 1, nodes)
    end
  },
  parallel: 2,
  warmup: 5,
  time: 10,
  memory_time: 5
)
