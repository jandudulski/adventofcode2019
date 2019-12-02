defmodule Day02 do
  @moduledoc """
  Documentation for Day02.
  """

  @doc """
  Answer to part 1.
  """
  def part1 do
    [a, _, _ | tail] = "input" |> File.read!() |> String.trim() |> parse_intcode()

    %{0 => result} = run_program([a, 12, 2 | tail])

    result
  end

  @doc """
  Answer to part 2.
  """
  def part2 do
    [a, _, _ | tail] = "input" |> File.read!() |> String.trim() |> parse_intcode()

    for noun <- 0..99, verb <- 0..99, into: %{} do
      %{0 => result} = run_program([a, noun, verb | tail])

      {result, 100 * noun + verb}
    end
    |> Map.get(19_690_720)
  end

  @doc """
  Runs an Intcode.

  ## Example

  iex> Day02.run_program([1,0,0,0,99]) |> Map.values() |> Enum.join(",")
  "2,0,0,0,99"
  iex> Day02.run_program([2,3,0,3,99]) |> Map.values() |> Enum.join(",")
  "2,3,0,6,99"
  iex> Day02.run_program([2,4,4,5,99,0]) |> Map.values() |> Enum.join(",")
  "2,4,4,5,99,9801"
  iex> Day02.run_program([1,1,1,4,99,5,6,0,99]) |> Map.values() |> Enum.join(",")
  "30,1,1,4,2,5,6,0,99"

  """
  def run_program(code) do
    code
    |> Enum.with_index()
    |> Enum.into(%{}, fn {k, v} -> {v, k} end)
    |> run_intcode(0)
  end

  defp parse_intcode(code) do
    code |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)
  end

  defp run_intcode(code, position) do
    case handle_opcode(code, position) do
      {:ok, code} -> run_intcode(code, position + 4)
      {:halt, code} -> code
      :error -> :error
    end
  end

  defp handle_opcode(code, position) do
    with pos_a <- Map.get(code, position + 1),
         val_a <- Map.get(code, pos_a),
         pos_b <- Map.get(code, position + 2),
         val_b <- Map.get(code, pos_b),
         ret_pos <- Map.get(code, position + 3) do
      case Map.fetch!(code, position) do
        1 -> {:ok, Map.put(code, ret_pos, val_a + val_b)}
        2 -> {:ok, Map.put(code, ret_pos, val_a * val_b)}
        99 -> {:halt, code}
        _ -> :error
      end
    end
  end
end
