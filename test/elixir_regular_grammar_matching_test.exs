defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  test "searches for nonterminals" do
    assert ElixirRegularGrammarMatching.search_nonterminal("AvOCaDo", "AOCD") == [5, 3, 2, 0]
  end

  test "applies an iteration of rules" do
    assert ElixirRegularGrammarMatching.apply_rules("AB", "ab",
      [{"A", "ABa"}, {"A", "b"}, {"B", "Bb"}, {"B", "b"}], "aABa") ==
      ["aAba", "aABba", "abBa", "aABaBa"]
  end
end
