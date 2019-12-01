defmodule Day01 do
  @moduledoc """
  Documentation for Day01.
  """

  @doc """
  Answer to part 1.
  """
  def part1 do
    "input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce(0, fn mass, total_fuel -> total_fuel + fuel_required_to_launch(mass) end)
  end

  @doc """
  Answer to part 2.
  """
  def part2 do
    "input"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.reduce(0, fn mass, total_fuel -> total_fuel + recurrent_fuel_required(mass) end)
  end

  @doc """
  Calculate fuel required to launch a module.

  ## Examples

      iex> Day01.fuel_required_to_launch(12)
      2
      iex> Day01.fuel_required_to_launch(14)
      2
      iex> Day01.fuel_required_to_launch(1969)
      654
      iex> Day01.fuel_required_to_launch(100756)
      33583

  """
  def fuel_required_to_launch(mass) do
    div(mass, 3) - 2
  end

  @doc """
  Calculate recurrent fuel required to launch.

  ## Examples

      iex> Day01.recurrent_fuel_required(14)
      2
      iex> Day01.recurrent_fuel_required(1969)
      966
      iex> Day01.recurrent_fuel_required(100756)
      50346

  """
  def recurrent_fuel_required(mass) do
    recurrent_fuel_required(mass, 0)
  end

  def recurrent_fuel_required(mass, acc) when mass <= 6, do: acc

  def recurrent_fuel_required(mass, acc) do
    with fuel <- fuel_required_to_launch(mass) do
      recurrent_fuel_required(fuel, acc + fuel)
    end
  end
end
