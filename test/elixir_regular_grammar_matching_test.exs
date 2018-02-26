defmodule ElixirRegularGrammarMatchingTest do
  use ExUnit.Case
  doctest ElixirRegularGrammarMatching

  test "searches for nonterminals" do
    assert ElixirRegularGrammarMatching.search_nonterminal("AvOCaDo", "AOCD") == [5, 3, 2, 0]
  end
end
