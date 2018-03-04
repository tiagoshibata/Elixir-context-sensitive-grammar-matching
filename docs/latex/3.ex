def apply_rules_until_length(terminals, rules, {states, visited}, max_length) do
  not_visited = MapSet.difference(states, visited)
  case Enum.fetch(not_visited, 0) do
    {:ok, state} ->
      new_states = apply_rules(rules, state)
      |> Enum.filter(&(String.length(&1) <= max_length))
      |> MapSet.new
      apply_rules_until_length(terminals, rules, {MapSet.union(states, new_states), MapSet.put(visited, state)}, max_length)
    :error ->
      {states, visited}
  end
end
