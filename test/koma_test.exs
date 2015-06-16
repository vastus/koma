defmodule KomaTest do
  use ExUnit.Case

  # .map
  test ".map returns empty array for []" do
    assert Koma.map([], fn (elem) -> elem * 2 end) == []
  end

  test ".map applies given function to singleton" do
    assert Koma.map([1], fn (elem) -> elem * 2 end) == [2]
  end

  test ".map applies given function to array's elements" do
    assert Koma.map([1, 2], fn (elem) -> elem * 2 end) == [2, 4]
  end

  # .reduce
  test ".reduce/2 returns element for singleton" do
    assert Koma.reduce([7], fn (elem, acc) -> elem + acc end) == 7
    assert Enum.reduce([7], fn (elem, acc) -> elem + acc end) == 7
    assert Koma.reduce([7], fn (elem, acc) -> elem * acc end) == 7
    assert Enum.reduce([7], fn (elem, acc) -> elem * acc end) == 7
    assert Koma.reduce([7], fn (elem, acc) -> elem / acc end) == 7
    assert Enum.reduce([7], fn (elem, acc) -> elem / acc end) == 7
  end

  test ".reduce/3 returns accumulator for []" do
    assert Koma.reduce([], 99, fn (elem, _acc) -> elem end) == 99
    assert Koma.reduce([], 99, fn (_elem, acc) -> acc end) == 99
    assert Koma.reduce([], 99, fn (_elem, _acc) -> nil end) == 99
    assert Koma.reduce([], 99, fn (_elem, _acc) -> 2 + 1 end) == 99
  end

  test ".reduce/3 returns what given function returns for non-empty array" do
    assert Koma.reduce([1], 99, fn (_elem, _acc) -> 22 + 20 end) == 42
    assert Koma.reduce([1, 2], 99, fn (_elem, _acc) -> 22 + 20 end) == 42
  end

  test ".reduce/3 invokes function passing elem" do
    assert Koma.reduce([1], 99, fn (elem, _acc) -> elem end) == 1
    assert Koma.reduce([1, 2], 99, fn (elem, _acc) -> elem end) == 2
    assert Koma.reduce([1, 2, 0], 99, fn (elem, _acc) -> elem end) == 0
  end

  test ".reduce/3 invokes function passing acc" do
    assert Koma.reduce([1], 99, fn (_elem, acc) -> acc end) == 99
    assert Koma.reduce([1, 2], 99, fn (_elem, acc) -> acc end) == 99
    assert Koma.reduce([1, 2], 99, fn (_elem, acc) -> acc end) == 99
  end

  test ".reduce/3 invokes function passing next element and accumulator" do
    assert Koma.reduce([1, 2], 0, fn (elem, acc) -> elem + acc end) == 3
    assert Koma.reduce([1, 2], 1, fn (elem, acc) -> elem + acc end) == 4
    assert Koma.reduce([2, 4], 1, fn (elem, acc) -> elem / acc end) == 2.0
    assert Koma.reduce([9, 9], 0, fn (elem, acc) -> elem * acc end) == 0
  end

  # test ".reduce/2 invokes function passing next element and first element as accumulator" do
  #   assert Koma.reduce([1, 2, 3], fn (elem, acc) -> elem + acc end) == 6
  #   assert Koma.reduce([], fn (elem, acc) -> elem end) == nil
  # end

  test ".join/1 returns empty string for []" do
    assert Koma.join([]) == ""
  end

  test ".join/1 returns string representation of element for a singleton" do
    assert Koma.join([1]) == "1"
  end

  test ".join/1 returns string of elements glued together by empty string" do
    assert Koma.join([1, 2]) == "12"
    assert Koma.join([1, 2, 3]) == "123"
  end

  test ".join/2 returns empty string for [] and empty string" do
    assert Koma.join([], "") == ""
  end

  test ".join/2 returns empty string for [] and any glue" do
    assert Koma.join([], ",") == ""
    assert Koma.join([], ", ") == ""
    assert Koma.join([], " MEAID ") == ""
  end

  test ".join/2 returns string representation of element for a singleton and any glue" do
    assert Koma.join([1], "") == "1"
    assert Koma.join([1], ",") == "1"
    assert Koma.join([1], ", ") == "1"
  end

  test ".join/2 returns string representation of elements glued together by given glue when size of list is > 1" do
    assert Koma.join([1, 2], "") == "12"
    assert Koma.join([1, 2], ",") == "1,2"
    assert Koma.join([1, 2], ", ") == "1, 2"
  end
end

