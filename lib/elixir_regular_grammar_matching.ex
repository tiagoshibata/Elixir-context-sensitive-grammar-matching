defmodule ElixirRegularGrammarMatching do
  def apply_rule(rule, state) do
    {condition, replacement} = rule
    case String.split(state, condition, parts: 2) do
      [left, right] ->
        {head, tail} = String.split_at(condition, 1)
        Enum.map(apply_rule(rule, right), &(left <> replacement <> &1))
        ++ Enum.map(apply_rule(rule, tail <> right), &(left <> head <> &1))
      [_] ->
        [state]
    end
  end

  def apply_rules(rules, state) do
    Enum.flat_map(rules, &(apply_rule(&1, state)))
  end

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

  def apply_rules_until_length(terminals, rules, state, max_length) do
    apply_rules_until_length(terminals, rules, {MapSet.new([state]), MapSet.new}, max_length)
    |> elem(1)
  end

  def can_generate_sentence(grammar, sentence) do
    {terminals, rules, start} = grammar
    apply_rules_until_length(terminals, rules, start, String.length(sentence))
    |> MapSet.member?(sentence)
  end
end
