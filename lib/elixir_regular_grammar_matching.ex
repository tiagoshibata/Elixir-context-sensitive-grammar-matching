defmodule ElixirRegularGrammarMatching do
  def apply_rules(nonterminals, terminals, rules, sentence) do
    search_nonterminal(sentence, nonterminals) |>
      Enum.flat_map(fn(i) ->
        nonterminal = String.at(sentence, i)
        Enum.reduce(rules, [], fn({condition, rule}, acc) ->
          if condition == nonterminal do
            [String.slice(sentence, 0..i - 1) <> rule <> String.slice(sentence, i + 1..-1) | acc]
          else
            acc
          end
        end)
      end)
  end

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
end
