defmodule ElixirRegularGrammarMatching do
  # def generate_from_grammar(grammar, length) do
  #   {nonterminals, terminals, rules, start} = grammar
  #   generate_from_grammar(nonterminals, terminals, rules, [start], length, MapSet.new)
  # end

  # def generate_from_grammar(nonterminals, terminals, rules, [], length, generated_sentences) do
  #   generated_sentences
  # end

  # def generate_from_grammar(nonterminals, terminals, rules, [sentence | nonterminal_sentences], length, generated_sentences) do
  #   filter(apply_rules(nonterminals, terminals, rules, sentence), tamanho)
  #   generated_sentences = generate_from_grammar(nonterminals, terminals, rules, nonterminal_sentences, length, generated_sentences)
  #   generate_from_grammar(nonterminals, terminals, rules, nonterminal_sentences, length, generated_sentences)
  # end

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
