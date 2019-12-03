defmodule Day03 do
  @moduledoc """
  Documentation for Day03.
  """

  @doc """
  Answer part 1.
  """
  def part1 do
    [wire1, wire2] =
      "input"
      |> File.read!()
      |> String.split("\n", trim: true)

    closest_intersection(wire1, wire2)
  end

  @doc """
  Answer part 2.
  """
  def part2 do
    [wire1, wire2] =
      "input"
      |> File.read!()
      |> String.split("\n", trim: true)

    fewest_steps(wire1, wire2)
  end

  @doc """
  Find distnce of closest intersection.

  ## Examples

      iex> Day03.closest_intersection("R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83")
      159
      iex> Day03.closest_intersection("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
      135

  """
  def closest_intersection(wire1, wire2) do
    with wire1 <- trace_path(wire1),
         wire2 <- trace_path(wire2) do
      intersections(wire1, wire2)
      |> Enum.min_by(&manhattan_distance({0, 0}, elem(&1, 0)))
      |> elem(0)
      |> manhattan_distance({0, 0})
    end
  end

  @doc """
  Find fewest steps of closest intersection.

  ## Examples

      iex> Day03.fewest_steps("R75,D30,R83,U83,L12,D49,R71,U7,L72", "U62,R66,U55,R34,D71,R55,D58,R83")
      610
      iex> Day03.fewest_steps("R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51", "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7")
      410

  """
  def fewest_steps(wire1, wire2) do
    with wire1 <- trace_path(wire1),
         wire2 <- trace_path(wire2) do
      intersections(wire1, wire2)
      |> Enum.min_by(&elem(&1, 1))
      |> elem(1)
    end
  end

  @doc """
  Find intersections between wires.

  ## Examples

      iex> wire1 = "R8,U5,L5,D3" |> Day03.trace_path()
      iex> wire2 = "U7,R6,D4,L4" |> Day03.trace_path()
      iex> Day03.intersections(wire1, wire2)
      [{{6, 5}, 30}, {{3, 3}, 40}]

  """
  def intersections(wire1, wire2) do
    wire1
    |> Enum.reduce([], fn {{x, y}, steps1}, intersections ->
      if steps2 = Map.get(wire2, {x, y}) do
        [{{x, y}, steps1 + steps2} | intersections]
      else
        intersections
      end
    end)
  end

  @doc """
  Trace wire path.

  ## Examples

      iex> path = "R3,U1,L1,D2"
      iex> Day03.trace_path(path)
      %{{1, 0} => 1, {2, 0} => 2, {3, 0} => 3, {3, 1} => 4, {2, 1} => 5, {2, -1} => 7}

  """
  def trace_path(path) do
    with init <- {%{}, {0, 0}} do
      {path, _} =
        path
        |> String.split(",")
        |> Enum.reduce(init, &move(&2, &1))

      path
    end
  end

  @doc """
  Move from coordinate in specific direction.

  ## Examples

      iex> path = %{}
      iex> coord = {0, 0}
      iex> Day03.move({path, coord}, "R3") |> Day03.move("U1") |> Day03.move("L1") |> Day03.move("D2")
      {
        %{{1, 0} => 1, {2, 0} => 2, {3, 0} => 3, {3, 1} => 4, {2, 1} => 5, {2, -1} => 7},
        {2, -1}
      }

  """
  def move({path, {x, y}}, <<"R", rest::binary>>) do
    with distance <- String.to_integer(rest),
         steps <- Map.get(path, {x, y}, 0) do
      path = 1..distance |> Enum.reduce(path, &Map.put_new(&2, {x + &1, y}, steps + &1))

      {path, {x + distance, y}}
    end
  end

  def move({path, {x, y}}, <<"L", rest::binary>>) do
    with distance <- String.to_integer(rest),
         steps <- Map.get(path, {x, y}, 0) do
      path = 1..distance |> Enum.reduce(path, &Map.put_new(&2, {x - &1, y}, steps + &1))

      {path, {x - distance, y}}
    end
  end

  def move({path, {x, y}}, <<"U", rest::binary>>) do
    with distance <- String.to_integer(rest),
         steps <- Map.get(path, {x, y}, 0) do
      path = 1..distance |> Enum.reduce(path, &Map.put_new(&2, {x, y + &1}, steps + &1))

      {path, {x, y + distance}}
    end
  end

  def move({path, {x, y}}, <<"D", rest::binary>>) do
    with distance <- String.to_integer(rest),
         steps <- Map.get(path, {x, y}, 0) do
      path = 1..distance |> Enum.reduce(path, &Map.put_new(&2, {x, y - &1}, steps + &1))

      {path, {x, y - distance}}
    end
  end

  @doc """
  Calculates Manhattan distance between coordinates.

  ## Examples

      iex> Day03.manhattan_distance({1, 6}, {5, 2})
      8

  """
  def manhattan_distance({p1, p2}, {q1, q2}) do
    abs(p1 - q1) + abs(p2 - q2)
  end
end
