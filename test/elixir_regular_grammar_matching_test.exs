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

  test "checks whether a grammar can generate a sentence" do
    grammar = {
      "AB",
      "ab",
      [{"A", "ABa"}, {"A", "a"}, {"B", "Bb"}, {"B", "b"}],
      "A"
    }
    assert ElixirRegularGrammarMatching.can_generate_sentence(grammar, "a")
    assert ElixirRegularGrammarMatching.can_generate_sentence(grammar, "aba")
    assert ElixirRegularGrammarMatching.can_generate_sentence(grammar, "abbabbba")
    assert not ElixirRegularGrammarMatching.can_generate_sentence(grammar, "ba")
    assert not ElixirRegularGrammarMatching.can_generate_sentence(grammar, "abab")
    context_sensitive_grammar = {
      "AB",
      "ab",
      [{"A", "aAa"}, {"aAa", "BaB"}, {"B", "Bb"}, {"B", "b"}],
      "A"
    }
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "bab")
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aabbbabaa")
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aaabbbbbabbaaa")
    assert not ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aabaaa")
  end
end
