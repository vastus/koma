defmodule Koma do
  def map([], _f), do: []

  def map([head | tail], f) do
    [f.(head) | map(tail, f)]
  end

  def reduce([], acc, _f), do: acc

  def reduce([first | rest], acc, f) do
    reduce(rest, f.(first, acc), f)
  end

  def reduce([first | rest], f) do
    reduce(rest, first, f)
  end

  def join(ary) when is_list(ary), do: join(ary, "")

  def join([], _glue), do: ""

  def join([elem], _glue), do: "#{elem}"

  def join([head | tail], glue) do
    "#{head}" <> glue <> join(tail, glue)
  end
end

