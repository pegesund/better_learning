defmodule BLTest do
  use ExUnit.Case
  doctest BL.Helpers

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "permutaions for only new exercises" do
    assert  BL.Helpers.permuteAnswers([1,2,3], []) == [{1, 2}, {1, 3}, {2, 3}] 
  end

  test "permutaions for old and new exercises" do
    assert  BL.Helpers.permuteAnswers([1,2], [3,4]) == [{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}]
  end

  test "permutations with no new ones" do
    assert  BL.Helpers.permuteAnswers([], [3,4]) == []
  end

end
