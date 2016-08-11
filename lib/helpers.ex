defmodule BL.Helpers do
  @moduledoc """
  Here are the functions to calculate how exercises are related to each other.

  We keep track of all exercises a person has managed or failed doing.

  If a pupil has failed on two exercises, we know there is a connection between them. For every pupil who fails on these two exercises the connection get stronger.

  Ex. if a pupil has failed on excercise [1,4,9] we know that there are permuted connections like this:

  `[{1, 4}, {1, 9}, {4, 9}]`

  We add up keep the connections all the students in a ordered tree:

`{1, 4} -> 6,
{1, 3} -> 2,
{1, 7} -> 0`

  This means that studens which have failed on exercise 1 also tend to miss on number 4

  If we include info about how many persons that normally answers right on the different answers, as well as how many attempts it takes before a person masters the exercise we have valuable information for calculating similarities.

  """

  @doc """

  Returns a list of connected answers.

  ## Examples

      iex> BL.Helpers.permuteAnswers([1,2],[3,4])
      [{1, 2}, {1, 3}, {1, 4}, {2, 3}, {2, 4}]

  """
  def permuteAnswers(people_answers, old_answers) do
    perms(people_answers) ++ permsOldAndNew(people_answers, old_answers)
  end

  defp permsOldAndNew(o, n) do
    for i <- o,
        j <- n,
        do: {i, j}
  end

  defp perms([]), do: []

  defp perms([h|t]) do
    (for i <- t, do: {h,i}) ++ perms(t)
  end

end
