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
