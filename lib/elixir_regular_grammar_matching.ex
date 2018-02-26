defmodule ElixirRegularGrammarMatching do
  def apply_rules(nonterminals, terminals, rules, sentence) do
    []
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
