defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  test "searches for nonterminals" do
    assert ElixirRegularGrammarMatching.search_nonterminal("AvOCaDo", "AOCD") == [5, 3, 2, 0]
  end

  test "applies an iteration of rules" do
    assert ElixirRegularGrammarMatching.apply_rules("AB",
      [{"A", "ABa"}, {"A", "b"}, {"B", "Bb"}, {"B", "b"}], "aABa") ==
      ["aAba", "aABba", "abBa", "aABaBa"]
  end

  test "checks whether a sentence has exclusively terminal characters" do
    assert ElixirRegularGrammarMatching.is_terminal("AB", "ab")
    assert ElixirRegularGrammarMatching.is_terminal("A", "")
    assert ElixirRegularGrammarMatching.is_terminal("", "ab")
    assert not ElixirRegularGrammarMatching.is_terminal("AB", "A")
    assert not ElixirRegularGrammarMatching.is_terminal("A", "aAb")
  end
end
