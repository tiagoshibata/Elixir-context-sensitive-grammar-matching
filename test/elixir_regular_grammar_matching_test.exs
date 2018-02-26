defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  # test "generates sentences from grammars" do
  #   assert ElixirRegularGrammarMatching.generate_from_grammar({
  #     {"A"},  # nonterminal symbols
  #     {"a"},  # terminal symbols
  #     [{"A", "Aa"}, {"A", "b"}],  # rules
  #     "A"  # starting symbol
  #   }, 2) == "A"
  # end

  # test "works with target sentences with length 0" do
  #   assert ElixirRegularGrammarMatching.generate_from_grammar({
  #     {"A"},  # nonterminal symbols
  #     {"a"},  # terminal symbols
  #     [{"A", "Aa"}, {"A", "b"}],  # rules
  #     "A"  # starting symbol
  #   }, 0) == []
  # end

  test "searches for nonterminals" do
    assert ElixirRegularGrammarMatching.search_nonterminal("AvOCaDo", "AOCD") == [5, 3, 2, 0]
  end

  test "applies an iteration of rules" do
    assert ElixirRegularGrammarMatching.apply_rules("AB", "ab",
      [{"A", "ABa"}, {"A", "b"}, {"B", "Bb"}, {"B", "b"}], "aABa") ==
      ["aAba", "aABba", "abBa", "aABaBa"]
  end
end
