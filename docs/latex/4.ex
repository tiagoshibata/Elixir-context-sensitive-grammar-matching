def apply_rules_until_length(terminals, rules, state, max_length) do
  apply_rules_until_length(terminals, rules, {MapSet.new([state]), MapSet.new}, max_length)
  |> elem(1)
end

def can_generate_sentence(grammar, sentence) do
  {terminals, rules, start} = grammar
  apply_rules_until_length(terminals, rules, start, String.length(sentence))
  |> MapSet.member?(sentence)
end
