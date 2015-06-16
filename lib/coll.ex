defprotocol Coll do
  @doc """
  Search given sorted list for a given needle using binary search.

  Not true binary search for lists b/c linked lists need linear time accessing
  elements for a given index. Check `Enum.at/3` for more information.
  """
  def bsearch(sorted_list, needle)
end

defimpl Coll, for: List do
  def bsearch([], _), do: nil
  def bsearch(list, needle) do
    bsearch(list, needle, 0, length(list))
  end

  defp bsearch(list, needle, lo, hi) do
    mid = div(lo + hi, 2)
    elem = Enum.at(list, mid)
    bsearch(list, needle, lo, hi, mid, elem)
  end

  defp bsearch(list, needle, lo, hi, mid, needle), do: {:ok, mid}

  defp bsearch(list, needle, lo, hi, mid, elem) when lo >= hi do
    {:not_found, -1}
  end

  defp bsearch(list, needle, lo, _hi, mid, _elem) when needle <= mid do
    bsearch(list, needle, lo, mid - 1)
  end

  defp bsearch(list, needle, _lo, hi, mid, _elem) when needle >= mid do
    bsearch(list, needle, mid + 1, hi)
  end
end

