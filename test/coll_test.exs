defmodule CollTest do
  use ExUnit.Case

  # bsearch
  test "bsearch returns nil on empty list" do
    assert Coll.bsearch([], 42) == nil
  end

  test "bsearch finds needle in singleton" do
    assert Coll.bsearch([42], 42) == {:ok, 0}
  end

  test "bsearch does not find needle in singleton" do
    assert Coll.bsearch([42], 69) == {:not_found, -1}
  end

  test "bsearch finds needle in a double" do
    assert Coll.bsearch([3, 42], 42) == {:ok, 1}
  end

  test "bsearch does not find needle in double" do
    assert Coll.bsearch([3, 5], 42) == {:not_found, -1}
  end

  test "bsearch finds needle in middle of list" do
    assert Coll.bsearch([23, 53, 77], 53) == {:ok, 1}
  end

  test "bsearch finds needle in haystack" do
    assert Coll.bsearch(Enum.to_list(0..100), 42) == {:ok, 42}
  end
  # /bsearch
end

