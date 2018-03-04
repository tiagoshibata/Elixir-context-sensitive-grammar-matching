defmodule ElixirRegularGrammarMatching do
  def search_nonterminal(state, nonterminals) do
    Enum.zip(to_charlist(state), 0..String.length(state)) |>
      Enum.reduce([], fn({x, index}, acc) ->
        if nonterminals =~ <<x>> do
          [index | acc]
        else
          acc
        end
      end)
  end

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

  def apply_rules(nonterminals, rules, state) do
    search_nonterminal(state, nonterminals) |>
      Enum.flat_map(fn(i) ->
        nonterminal = String.at(state, i)
        Enum.reduce(rules, [], fn({condition, rule}, acc) ->
          if condition == nonterminal do
            [String.slice(state, 0, i) <> rule <> String.slice(state, i + 1..-1) | acc]
          else
            acc
          end
        end)
      end)
  end

  def is_terminal(terminals, state) do
    Enum.all?(to_charlist(state), &(terminals =~ <<&1>>))
  end

  def apply_rules_until_length(nonterminals, terminals, rules, state, max_length) do
    cond do
      is_terminal(terminals, state) ->
        [state]
      String.length(state) > max_length ->
        []
      true ->
        Enum.flat_map(apply_rules(nonterminals, rules, state), &(apply_rules_until_length(nonterminals, terminals, rules, &1, max_length))) |>
          Enum.filter(&(String.length(&1) <= max_length))
    end
  end

  def can_generate_sentence(grammar, sentence) do
    {nonterminals, terminals, rules, start} = grammar
    Enum.any?(apply_rules_until_length(nonterminals, terminals, rules, start, String.length(sentence)), &(&1 == sentence))
  end
end
