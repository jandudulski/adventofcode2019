defmodule Day04 do
  @moduledoc """
  Documentation for Day04.
  """

  @doc """
  Answer part 1.
  """
  def part1 do
    359_282..820_401
    |> Stream.map(&Integer.digits/1)
    |> Enum.count(&(not_decrease?(&1) && same_adjacent?(&1)))
  end

  @doc """
  Answer part 2.
  """
  def part2 do
    359_282..820_401
    |> Stream.map(&Integer.digits/1)
    |> Enum.count(&(not_decrease?(&1) && double_adjacent?(&1)))
  end

  @doc """
  Check if password meets never decrease criteria.

  ## Examples

      iex> Day04.not_decrease?(111111)
      true
      iex> Day04.not_decrease?(122345)
      true
      iex> Day04.not_decrease?(111123)
      true
      iex> Day04.not_decrease?(135679)
      true
      iex> Day04.not_decrease?(223450)
      false
      iex> Day04.not_decrease?(123789)
      true

  """
  def not_decrease?(num) when is_number(num) do
    num |> Integer.digits() |> not_decrease?()
  end

  def not_decrease?([a, b, _, _, _, _]) when a > b, do: false
  def not_decrease?([_, a, b, _, _, _]) when a > b, do: false
  def not_decrease?([_, _, a, b, _, _]) when a > b, do: false
  def not_decrease?([_, _, _, a, b, _]) when a > b, do: false
  def not_decrease?([_, _, _, _, a, b]) when a > b, do: false
  def not_decrease?(_), do: true

  @doc """
  Check if password meets adjacent pair criteria.

  ## Examples

      iex> Day04.same_adjacent?(111111)
      true
      iex> Day04.same_adjacent?(122345)
      true
      iex> Day04.same_adjacent?(111123)
      true
      iex> Day04.same_adjacent?(135679)
      false
      iex> Day04.same_adjacent?(223450)
      true
      iex> Day04.same_adjacent?(123789)
      false

  """
  def same_adjacent?(num) when is_number(num) do
    num |> Integer.digits() |> same_adjacent?()
  end

  def same_adjacent?([a, a, _, _, _, _]), do: true
  def same_adjacent?([_, a, a, _, _, _]), do: true
  def same_adjacent?([_, _, a, a, _, _]), do: true
  def same_adjacent?([_, _, _, a, a, _]), do: true
  def same_adjacent?([_, _, _, _, a, a]), do: true
  def same_adjacent?(_), do: false

  @doc """
  Check if password meets double adjacent criteria.

  ## Examples

      iex> Day04.double_adjacent?(111111)
      false
      iex> Day04.double_adjacent?(122345)
      true
      iex> Day04.double_adjacent?(111123)
      false
      iex> Day04.double_adjacent?(135679)
      false
      iex> Day04.double_adjacent?(223450)
      true
      iex> Day04.double_adjacent?(123789)
      false
      iex> Day04.double_adjacent?(111122)
      true

  """
  def double_adjacent?(num) when is_number(num) do
    num |> Integer.digits() |> double_adjacent?()
  end

  def double_adjacent?([a, a, b, _, _, _]) when a != b, do: true
  def double_adjacent?([b, a, a, c, _, _]) when a != b and a != c, do: true
  def double_adjacent?([_, b, a, a, c, _]) when a != b and a != c, do: true
  def double_adjacent?([_, _, b, a, a, c]) when a != b and a != c, do: true
  def double_adjacent?([_, _, _, b, a, a]) when a != b, do: true
  def double_adjacent?(_), do: false
end
