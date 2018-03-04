def apply_rules(rules, state) do
  Enum.flat_map(rules, &(apply_rule(&1, state)))
end
