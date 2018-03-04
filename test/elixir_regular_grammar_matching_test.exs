defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  def assert_have_same_elements(a, b) do
    assert MapSet.new(a) == MapSet.new(b)
  end

  test "applies a rule" do
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rule(
      {"A", "a"}, "AA"),
      ["AA", "aA", "Aa", "aa"])
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rule(
      {"AA", "aa"}, "AAA"),
      ["AAA", "aaA", "Aaa"])
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rule(
      {"A", "a"}, ""),
      [""])
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rule(
      {"ABA", "a"}, "ABABA"),
      ["ABABA", "aBA", "ABa"])
  end

  test "applies an iteration of rules" do
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rules(
      [{"A", "aA"}, {"A", "ab"}], "A"),
      ["A", "aA", "ab"])
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rules(
      [{"A", "ABa"}, {"A", "b"}, {"B", "Bb"}, {"B", "b"}], "aABa"),
      ["aABa", "aABaBa", "abBa", "aABba", "aAba"])
    assert_have_same_elements(ElixirRegularGrammarMatching.apply_rules(
      [{"A", "aAa"}, {"aAa", "BaB"}, {"B", "b"}], "BaAa"),
      ["BaAa", "BaaAaa", "BBaB", "baAa"])
  end

  test "applies rules until an specific length" do
    assert ElixirRegularGrammarMatching.apply_rules_until_length("a", [], "aa", 1) == MapSet.new(["aa"])
    assert ElixirRegularGrammarMatching.apply_rules_until_length("ab",
        [{"A", "aA"}, {"A", "ab"}], "A", 4) ==
      MapSet.new(["A", "aA", "aaA", "aaaA", "aaab", "aab", "ab"])
    assert ElixirRegularGrammarMatching.apply_rules_until_length("ab",
      [{"A", "a"}, {"A", "aAa"}, {"aAa", "bAb"}], "A", 5) ==
      MapSet.new(["A", "a", "aAa", "aaAaa", "aaa", "aaaaa", "abAba", "ababa", "bAb", "baAab", "baaab", "bab", "bbAbb", "bbabb"])
    assert ElixirRegularGrammarMatching.apply_rules_until_length("ab",
      [{"A", "B"}, {"B", "A"}, {"A", "a"}], "A", 3) ==
      MapSet.new(["A", "B", "a"])
  end

  test "checks whether a grammar can generate a sentence" do
    grammar = {
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
      "ab",
      [{"A", "aAa"}, {"aAa", "BaB"}, {"B", "Bb"}, {"B", "b"}],
      "A"
    }
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "bab")
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aabbbabaa")
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aaabbabaaa")
    assert not ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aabaaa")
    context_sensitive_grammar = {
      "ab",
      [{"A", "B"}, {"B", "A"}, {"A", "a"}],
      "A"
    }
    assert ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "a")
    assert not ElixirRegularGrammarMatching.can_generate_sentence(context_sensitive_grammar, "aaa")
  end
end
