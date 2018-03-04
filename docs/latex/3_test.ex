test "applies rules until an specific length" do
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
