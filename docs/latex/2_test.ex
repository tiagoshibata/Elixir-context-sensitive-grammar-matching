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
