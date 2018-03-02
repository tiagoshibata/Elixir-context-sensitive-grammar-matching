defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  test "searches for nonterminals" do
    assert ElixirRegularGrammarMatching.search_nonterminal("A", "A") == [0]
    assert ElixirRegularGrammarMatching.search_nonterminal("AvOCaDo", "AOCD") == [5, 3, 2, 0]
  end

  test "applies an iteration of rules" do
    assert ElixirRegularGrammarMatching.apply_rules("AB",
      [{"A", "aA"}, {"A", "ab"}], "A") ==
      ["ab", "aA"]
    assert ElixirRegularGrammarMatching.apply_rules("AB",
      [{"A", "ABa"}, {"A", "b"}, {"B", "Bb"}, {"B", "b"}], "aABa") ==
      ["aAba", "aABba", "abBa", "aABaBa"]
  end

  test "checks whether a sentence has exclusively terminal characters" do
    assert ElixirRegularGrammarMatching.is_terminal("ab", "ab")
    assert ElixirRegularGrammarMatching.is_terminal("", "")
    assert not ElixirRegularGrammarMatching.is_terminal("", "ab")
    assert not ElixirRegularGrammarMatching.is_terminal("ab", "A")
    assert not ElixirRegularGrammarMatching.is_terminal("ab", "aAb")
  end

  test "applies rules until an specific length" do
    assert ElixirRegularGrammarMatching.apply_rules_until_length("AB", "ab",
      [{"A", "aA"}, {"A", "ab"}], "A", 4) ==
      ["ab", "aab", "aaab"]
  end
end
