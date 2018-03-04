defmodule ElixirRegularGrammarMatching do
  def apply_rule(rule, state) do
    {condition, replacement} = rule
    Enum.reduce(String.split(state, condition), nil, fn(part, acc) ->
      if is_nil(acc) do
        [part]
      else
        Enum.map(acc, &(&1 <> condition <> part)) ++ Enum.map(acc, &(&1 <> replacement <> part))
      end
    end) |>
      Enum.filter(&(&1 != state))
  end

  def apply_rules(rules, state) do
    Enum.flat_map(rules, &(apply_rule(&1, state)))
  end

  def is_terminal(terminals, state) do
    Enum.all?(to_charlist(state), &(terminals =~ <<&1>>))
  end

  def apply_rules_until_length(terminals, rules, state, max_length) do
    cond do
      String.length(state) > max_length ->
        MapSet.new
      is_terminal(terminals, state) ->
        MapSet.new([state])
      true ->
        Enum.reduce(apply_rules(rules, state), MapSet.new,
          &(MapSet.union(&2, apply_rules_until_length(terminals, rules, &1, max_length))))
    end
  end

  def can_generate_sentence(grammar, sentence) do
    {terminals, rules, start} = grammar
    MapSet.member?(apply_rules_until_length(terminals, rules, start, String.length(sentence)), sentence)
  end
end
