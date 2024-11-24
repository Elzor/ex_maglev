defmodule ExMaglevTest do
  use ExMaglev.Case, async: false
  doctest ExMaglev

  describe "common" do
    test "check lxcode/0 returns" do
      assert ExMaglev.lxcode() == {:ok, :vsn1}
    end
  end

  describe "app" do
    test "correct loading" do
      Application.stop(@app)
      Application.unload(@app)
      assert :ok == Application.load(@app)
    end
  end

  describe "filter" do
    test "new" do
      nodes = ["a", "b", "c"]
      {:ok, ref} = ExMaglev.new(nodes, length(nodes))
      assert is_reference(ref)
      {:ok, 3} = ExMaglev.get_capacity(ref)
      {:ok, ^nodes} = ExMaglev.get_nodes(ref)
    end

    test "hash" do
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
      {:ok, "Friday"} = ExMaglev.hash(ref, "alice")
      {:ok, "Wednesday"} = ExMaglev.hash(ref, "bob")
      {:ok, 701 = prev_capacity} = ExMaglev.get_capacity(ref)

      new_nodes = [
        "Monday",
        "Tuesday",
        "Wednesday",
        # "Thursday",
        # "Friday",
        "Saturday",
        "Sunday"
      ]

      {:ok, new_ref} = ExMaglev.new(new_nodes, prev_capacity)

      {:ok, "Saturday"} = ExMaglev.hash(new_ref, "alice")
      {:ok, "Wednesday"} = ExMaglev.hash(new_ref, "bob")
    end

    test "hash for empty nodes" do
      {:ok, ref} = ExMaglev.new([])
      {:ok, nil} = ExMaglev.hash(ref, "alice")
    end
  end
end
