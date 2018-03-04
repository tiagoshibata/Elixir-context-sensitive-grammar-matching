def apply_rule(rule, state) do
  {condition, replacement} = rule
  case String.split(state, condition, parts: 2) do
    [left, right] ->
      {head, tail} = String.split_at(condition, 1)
      Enum.map(apply_rule(rule, right), &(left <> replacement <> &1))
      ++ Enum.map(apply_rule(rule, tail <> right), &(left <> head <> &1))
    [_] ->
      [state]
  end
end
