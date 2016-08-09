defmodule BL.Helpers do
  def permuteAnswers(people_answers, old_answers) do
    perms(people_answers) ++ permsOldAndNew(people_answers, old_answers)
  end

  def permsOldAndNew(o, n) do
    for i <- o,
        j <- n,
        do: {i, j}
  end

  defp perms([]), do: []
  
  defp perms([h|t]) do
    (for i <- t, do: {h,i}) ++ perms(t)
  end

end
