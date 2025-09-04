defmodule Polarity do
  @moduledoc """
  Magnet puzzle solver with full recursive backtracking.
  """

  def polarity(board, specs) do
    result = board |> Tuple.to_list() |> Enum.map(&String.replace(&1, ~r/./, "X"))

    mspecs = %{
      top:    Tuple.to_list(specs["top"]),
      bottom: Tuple.to_list(specs["bottom"]),
      left:   Tuple.to_list(specs["left"]),
      right:  Tuple.to_list(specs["right"])
    }

    board_list = board |> Tuple.to_list()

    case solve(board_list, result, mspecs, 0, 0) do
      {:ok, result_rows, _specs} -> List.to_tuple(result_rows)
      :fail -> raise "No valid solution found"
    end
  end

  # Main recursive backtracking function
  defp solve(board, result, mspecs, i, j) do
    rows = length(board)
    cols = String.length(Enum.at(board, 0))

    cond do
      i == rows ->
        if check_specs(mspecs) do
          {:ok, result, mspecs}
        else
          :fail
        end

      j == cols ->
        solve(board, result, mspecs, i + 1, 0)

      true ->
        brd_type = String.at(Enum.at(board, i), j)
        res_type = String.at(Enum.at(result, i), j)

        # Try placing a magnet if possible
        place_result =
          if can_place?(mspecs, brd_type, res_type, result, i, j) do
            new_result = place_magnet(result, brd_type, i, j)
            new_specs = update_specs(mspecs, brd_type, i, j)
            solve(board, new_result, new_specs, i, j + 1)
          else
            :fail
          end

        case place_result do
          {:ok, _, _} = ok -> ok
          _ -> solve(board, result, mspecs, i, j + 1)
        end
    end
  end

  # Can we place a magnet at this cell?
  defp can_place?(mspecs, brd_type, "X", result, i, j) do
    brd_type in ["L", "R", "T", "B"] and
      safePlace(mspecs, brd_type, "X", i, j) and
      surroundings(brd_type, result, i, j)
  end
  defp can_place?(_, _, _, _, _, _), do: false

  # Your safePlace, surroundings, update_specs, place_magnet, check_specs, and safe_char_at helpers remain unchanged

  defp safePlace(mspecs, brd_type, "X", i, j) do
    case brd_type do
      "L" ->
        Enum.at(mspecs.top, j) != 0 &&
        Enum.at(mspecs.left, i) != 0 &&
        Enum.at(mspecs.bottom, j+1) != 0 &&
        Enum.at(mspecs.right, i) != 0

      "R" ->
        Enum.at(mspecs.top, j) != 0 &&
        Enum.at(mspecs.left, i) != 0 &&
        Enum.at(mspecs.bottom, j-1) != 0 &&
        Enum.at(mspecs.right, i) != 0

      "T" ->
        Enum.at(mspecs.top, j) != 0 &&
        Enum.at(mspecs.left, i) != 0 &&
        Enum.at(mspecs.bottom, j) != 0 &&
        Enum.at(mspecs.right, i+1) != 0

      "B" ->
        Enum.at(mspecs.top, j) != 0 &&
        Enum.at(mspecs.left, i) != 0 &&
        Enum.at(mspecs.bottom, j) != 0 &&
        Enum.at(mspecs.right, i-1) != 0

      _ -> false
    end
  end
  defp safePlace(_, _, _, _, _), do: false

  defp surroundings(brd_type, result, i, j) do
    case brd_type do
      "L" ->
        (safe_char_at(result, i+1, j) != "+" and
         safe_char_at(result, i-1, j) != "+" and
         safe_char_at(result, i, j+1) != "+" and
         safe_char_at(result, i, j-1) != "+") and

        (safe_char_at(result, i+1, j+1) != "-" and
         safe_char_at(result, i-1, j+1) != "-" and
         safe_char_at(result, i, j+2) != "-" and
         safe_char_at(result, i, j) != "-")

      "T" ->
        (safe_char_at(result, i+1, j) != "+" and
         safe_char_at(result, i-1, j) != "+" and
         safe_char_at(result, i, j+1) != "+" and
         safe_char_at(result, i, j-1) != "+") and

        (safe_char_at(result, i+2, j) != "-" and
         safe_char_at(result, i, j) != "-" and
         safe_char_at(result, i, j+1) != "-" and
         safe_char_at(result, i, j-1) != "-")

      "R" ->
        (safe_char_at(result, i+1, j) != "+" and
         safe_char_at(result, i-1, j) != "+" and
         safe_char_at(result, i, j+1) != "+" and
         safe_char_at(result, i, j-1) != "+") and

        (safe_char_at(result, i+1, j-1) != "-" and
         safe_char_at(result, i-1, j-1) != "-" and
         safe_char_at(result, i+1, j) != "-" and
         safe_char_at(result, i+1, j-2) != "-")

      "B" ->
        (safe_char_at(result, i+1, j) != "+" and
         safe_char_at(result, i-1, j) != "+" and
         safe_char_at(result, i, j+1) != "+" and
         safe_char_at(result, i, j-1) != "+") and

        (safe_char_at(result, i, j) != "-" and
         safe_char_at(result, i-2, j) != "-" and
         safe_char_at(result, i-1, j+1) != "-" and
         safe_char_at(result, i-1, j-1) != "-")

      _ -> false
    end
  end

  defp safe_char_at(result, i, j) do
    row = Enum.at(result, i)
    if is_binary(row) and j >= 0 and j < String.length(row) do
      String.at(row, j)
    else
      nil
    end
  end

  defp check_specs(mspecs) do
    mspecs_asList = mspecs |> Map.values() |> List.flatten()
    max_val = mspecs_asList |> Enum.max()
    max_val <= 0
  end

  defp update_specs(mspecs, brd_type, i, j) do
    case brd_type do
      "L" ->
        top_temp = Map.get(mspecs, :top)
        left_temp = Map.get(mspecs, :left)
        right_temp = Map.get(mspecs, :right)
        bottom_temp = Map.get(mspecs, :bottom)

        top_temp = List.update_at(top_temp, j, &(&1 -1))
        left_temp = List.update_at(left_temp, i, &(&1 -1))
        right_temp = List.update_at(right_temp, i, &(&1 -1))
        bottom_temp = List.update_at(bottom_temp, j+1, &(&1 -1))

        mspecs
        |> Map.put(:top, top_temp)
        |> Map.put(:left, left_temp)
        |> Map.put(:right, right_temp)
        |> Map.put(:bottom, bottom_temp)

      "R" ->
        top_temp = Map.get(mspecs, :top)
        left_temp = Map.get(mspecs, :left)
        right_temp = Map.get(mspecs, :right)
        bottom_temp = Map.get(mspecs, :bottom)

        top_temp = List.update_at(top_temp, j, &(&1 -1))
        left_temp = List.update_at(left_temp, i, &(&1 -1))
        right_temp = List.update_at(right_temp, i, &(&1 -1))
        bottom_temp = List.update_at(bottom_temp, j-1, &(&1 -1))

        mspecs
        |> Map.put(:top, top_temp)
        |> Map.put(:left, left_temp)
        |> Map.put(:right, right_temp)
        |> Map.put(:bottom, bottom_temp)

      "T" ->
        top_temp = Map.get(mspecs, :top)
        left_temp = Map.get(mspecs, :left)
        right_temp = Map.get(mspecs, :right)
        bottom_temp = Map.get(mspecs, :bottom)

        top_temp = List.update_at(top_temp, j, &(&1 -1))
        left_temp = List.update_at(left_temp, i, &(&1 -1))
        right_temp = List.update_at(right_temp, i+1, &(&1 -1))
        bottom_temp = List.update_at(bottom_temp, j, &(&1 -1))

        mspecs
        |> Map.put(:top, top_temp)
        |> Map.put(:left, left_temp)
        |> Map.put(:right, right_temp)
        |> Map.put(:bottom, bottom_temp)

      "B" ->
        top_temp = Map.get(mspecs, :top)
        left_temp = Map.get(mspecs, :left)
        right_temp = Map.get(mspecs, :right)
        bottom_temp = Map.get(mspecs, :bottom)

        top_temp = List.update_at(top_temp, j, &(&1 -1))
        left_temp = List.update_at(left_temp, i, &(&1 -1))
        right_temp = List.update_at(right_temp, i-1, &(&1 -1))
        bottom_temp = List.update_at(bottom_temp, j, &(&1 -1))

        mspecs
        |> Map.put(:top, top_temp)
        |> Map.put(:left, left_temp)
        |> Map.put(:right, right_temp)
        |> Map.put(:bottom, bottom_temp)
    end
  end

  defp place_magnet(resultArr, brd_type, i, j) do
    case brd_type do
      "L" ->
        temp = Enum.at(resultArr, i) |> String.graphemes()
        temp = List.replace_at(temp, j, "+")
        temp = List.replace_at(temp, j+1, "-")
        updated_row = Enum.join(temp)
        List.replace_at(resultArr, i, updated_row)

      "R" ->
        temp = Enum.at(resultArr, i) |> String.graphemes()
        temp = List.replace_at(temp, j, "+")
        temp = List.replace_at(temp, j-1, "-")
        updated_row = Enum.join(temp)
        List.replace_at(resultArr, i, updated_row)

      "T" ->
        tempT = Enum.at(resultArr, i) |> String.graphemes()
        tempB = Enum.at(resultArr, i+1) |> String.graphemes()
        tempT = List.replace_at(tempT, j, "+")
        tempB = List.replace_at(tempB, j, "-")
        updated_T = Enum.join(tempT)
        updated_B = Enum.join(tempB)
        resultArr = List.replace_at(resultArr, i, updated_T)
        List.replace_at(resultArr, i+1, updated_B)

      "B" ->
        tempT = Enum.at(resultArr, i-1) |> String.graphemes()
        tempB = Enum.at(resultArr, i) |> String.graphemes()
        tempT = List.replace_at(tempT, j, "-")
        tempB = List.replace_at(tempB, j, "+")
        updated_T = Enum.join(tempT)
        updated_B = Enum.join(tempB)
        resultArr = List.replace_at(resultArr, i-1, updated_T)
        List.replace_at(resultArr, i, updated_B)
    end
  end
end