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
