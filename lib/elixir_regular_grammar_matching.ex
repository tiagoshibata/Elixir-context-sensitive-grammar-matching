defmodule ElixirRegularGrammarMatching do
  def search_nonterminal(sentence, nonterminals) do
    Enum.zip(to_charlist(sentence), 0..String.length(sentence)) |>
      Enum.reduce([], fn({x, index}, acc) ->
        if nonterminals =~ <<x>> do
          [index | acc]
        else
          acc
        end
      end)
  end

  def apply_rules(nonterminals, rules, sentence) do
    search_nonterminal(sentence, nonterminals) |>
      Enum.flat_map(fn(i) ->
        nonterminal = String.at(sentence, i)
        Enum.reduce(rules, [], fn({condition, rule}, acc) ->
          if condition == nonterminal do
            [String.slice(sentence, 0, i) <> rule <> String.slice(sentence, i + 1..-1) | acc]
          else
            acc
          end
        end)
      end)
  end

  def is_terminal(terminals, sentence) do
    Enum.all?(to_charlist(sentence), &(terminals =~ <<&1>>))
  end

  def apply_rules_until_length(nonterminals, terminals, rules, sentence, max_length) do
    cond do
      is_terminal(terminals, sentence) ->
        [sentence]
      String.length(sentence) > max_length ->
        []
      true ->
        Enum.flat_map(apply_rules(nonterminals, rules, sentence), &(apply_rules_until_length(nonterminals, terminals, rules, &1, max_length))) |>
          Enum.filter(&(String.length(&1) <= max_length))
    end
  end
end
