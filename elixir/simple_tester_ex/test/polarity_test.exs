defmodule PolarityTest do
  use ExUnit.Case
  doctest Polarity

  test "test_1_5x6 " do 
    
    specs = %{ "left"=>{2, 3, -1, -1, -1}, 
        "right"=>{-1, -1, -1, 1, -1},
        "top"=>{1, -1, -1, 2, 1, -1},
        "bottom"=>{2, -1, -1, 2, -1, 3}
      }
    board = { "LRLRTT", "LRLRBB", "TTTTLR", "BBBBTT", "LRLRBB" }
    
    File.write("ex_log.txt", "1  -   5x6: ")
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"
    
    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_2a_2x2 " do

    specs = %{ "left"=>{1, 1}, "right"=>{1, 1}, "top"=>{1, 1}, "bottom"=>{1, 1} }
    board = { "TT", "BB" }

    File.write("ex_log.txt", "\n2a -   2x2: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_2b_2x2 " do 
    
    specs = %{ "left"=>{1, -1}, "right"=>{1, -1}, "top"=>{1, -1}, "bottom"=>{-1, 1} }
    board = { "LR", "LR" }

    File.write("ex_log.txt", "\n2b -   2x2: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_3a_4x4 " do
    
    specs = %{ "left"=>{0, 1, 2, -1}, 
        "right"=>{0, -1, 1, 2},
        "top"=>{1, 1, -1, 1},
        "bottom"=>{1, 1, 0, 2}
      }
    board = { "TTLR", "BBLR", "LRTT", "LRBB" }

    File.write("ex_log.txt", "\n3a -   4x4: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_3b_4x4 " do 
    
    specs = %{ "left"=>{1, 2, -1, -1}, 
        "right"=>{-1, 2, -1, 2},
        "top"=>{2, -1, 0, 2},
        "bottom"=>{2, -1, 2, 2}
      }
    board = { "TLRT", "BLRB", "TLRT", "BLRB" }

    File.write("ex_log.txt", "\n3b -   4x4: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_4a_8x8 " do 
    
    specs = %{ "left"=>{-1, -1, 2, 2, 4, -1, 3, 2}, 
        "right"=>{-1, 1, -1, 3, 3, -1, -1, 4},
        "top"=>{0, 4, 3, 3, -1, 3, -1, 1},
        "bottom"=>{2, 2, 3, 3, 2, -1, 1, 3}
      }
    board = { "LRTTLRTT", "LRBBLRBB", "TTLRTTLR", "BBLRBBLR", 
              "LRTTLRTT", "LRBBLRBB", "TTLRTTLR", "BBLRBBLR"}

    File.write("ex_log.txt", "\n4a -   8x8: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_4b_8x8 " do 
    
    specs = %{ "left"=>{-1, 2, 2, 2, 2, 2, 2, 0}, 
        "right"=>{1, 1, 1, -1, 3, 3, -1, -1},
        "top"=>{1, 0, 2, 3, 2, -1, 2, 2},
        "bottom"=>{0, 2, 1, 3, 2, 2, 1, -1}
      }
    board = { "LRLRLRLR", "LRLRTLRT", "TTTTBTTB", "BBBBTBBT", 
              "LRLRBTTB", "TLRTTBBT", "BLRBBLRB", "LRLRLRLR"}

    File.write("ex_log.txt", "\n4b -   8x8: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms", [:append])
  end

  test "test_5_16x16 " do 
    
    specs = %{ "left"=>{-1, -1, -1, 2, 1, 4, 1, 2, 0, 2, -1, 3, 2, -1, -1, 1}, 
        "right"=>{0, 0, 3, 2, 1, 2, 3, 2, 0, 1, -1, -1, 2, 1, 1, 1},
        "top"=>{1, 0, 0, 1, -1, 3, 2, 2, 1, -1, 3, 1, 2, -1, 2, -1},
        "bottom"=>{1, -1, -1, 1, 3, 1, 3, 1, 0, 2, -1, 3, 2, 3, 2, 0}
      }
    board = { "LRLRTTTTTTTTLRLR", "LRLRBBBBBBBBLRLR", "LRTTTTLRTTLRLRTT", "LRBBBBLRBBLRLRBB",  
	            "LRLRLRLRLRLRLRLR", "TLRTTLRTTLRTTLRT", "BLRBBLRBBLRBBLRB", "TTLRLRLRTTLRTTLR", 
		         	"BBLRLRLRBBLRBBLR", "TTLRTLRTLRTTTTLR", "BBLRBLRBLRBBBBLR", "LRLRLRLRLRLRLRLR",
					    "LRLRTTLRLRLRTTTT", "LRLRBBLRLRLRBBBB", "TLRTTTTTTLRTTTTT", "BLRBBBBBBLRBBBBB" }

    File.write("ex_log.txt", "\n5  - 16x16: ", [:append])
    {time, sol} = :timer.tc(fn -> Polarity.polarity board, specs end)

    a1 = validate_dimensions sol, board
    assert a1, "Solution and board dimensions don't match!"
    a2 = validate_placement sol, board
    assert a2, "Found illegal tile placement! Must be one of XX, +-, or -+"
    a3 = validate_poles sol
    assert a3, "Found same adjecent polarity! (++ or --)"  
    a4 = validate_constraints sol, specs
    assert a4, "Constraints not satisfied!"

    File.write("ex_log.txt", "Passed in #{div(time, 1000)} ms\n", [:append])
  end

  def validate_dimensions(sol, board) do
    sli = Tuple.to_list(sol)
    bli = Tuple.to_list(board)
    zipped = Enum.zip(sli, bli)
    same_height = length(sli) == length(bli)
    same_width = Enum.all?(zipped, fn {x, y} -> String.length(x) == String.length(y) end)
    same_height && same_width
  end

  def validate_placement(sol, board) do
    bli = Tuple.to_list(board)
    rows = length bli
    cols = String.length hd(bli)
    tiles = for r <- 0..rows-1, c <- 0..cols-1, do: get_tiles(sol, board, r, c) 
    Enum.all? tiles, fn {s, _} -> s == {"X", "X"} || s == {"+", "-"} || s == {"-", "+"} end    
  end

  def validate_poles(sol) do
    rows = tuple_size sol
    cols = elem(sol, 0) |> String.length
    
    row_poles = for r <- 0..rows-1, c <- 0..cols-2, do: 
      {String.at(elem(sol, r), c), String.at(elem(sol, r), c+1)}
    row_psd = Enum.all? row_poles, fn {a, b} -> a == "X" || a != b end

    col_poles = for c <- 0..cols-1, r <- 0..rows-2, do: 
      {String.at(elem(sol, r), c), String.at(elem(sol, r+1), c)}
    col_psd = Enum.all? col_poles, fn {a, b} -> a == "X" || a != b end

    col_psd && row_psd
  end

  def validate_constraints(sol, constraints) do
    sli_rows = Enum.map Tuple.to_list(sol), fn x -> String.codepoints(x) end
    sli_cols = transpose sli_rows

    plus_row = for r <- sli_rows, do: Enum.count r, &(&1 == "+")
    plus_col = for c <- sli_cols, do: Enum.count c, &(&1 == "+")
    minus_row = for r <- sli_rows, do: Enum.count r, &(&1 == "-")
    minus_col = for c <- sli_cols, do: Enum.count c, &(&1 == "-")
    
    plus_row_cons = Tuple.to_list constraints["left"]
    plus_col_cons = Tuple.to_list constraints["top"]
    minus_row_cons = Tuple.to_list constraints["right"]
    minus_col_cons = Tuple.to_list constraints["bottom"]

    plus_row_zip = Enum.zip plus_row, plus_row_cons
    plus_col_zip = Enum.zip plus_col, plus_col_cons
    minus_row_zip = Enum.zip minus_row, minus_row_cons
    minus_col_zip = Enum.zip minus_col, minus_col_cons

    plus_row_psd = Enum.all? plus_row_zip, fn {s, c} -> c == -1 || s == c end
    plus_col_psd = Enum.all? plus_col_zip, fn {s, c} -> c == -1 || s == c end
    minus_row_psd = Enum.all? minus_row_zip, fn {s, c} -> c == -1 || s == c end
    minus_col_psd = Enum.all? minus_col_zip, fn {s, c} -> c == -1 || s == c end

    plus_row_psd && plus_col_psd && minus_row_psd && minus_col_psd
  end

  def transpose([[] | _]), do: []
  def transpose(m) do
    [Enum.map(m, &hd/1) | transpose(Enum.map(m, &tl/1))]
  end
  
  def get_tiles(sol, board, x, y) do
    b1 = String.at(elem(board, x), y)
    s1 = String.at(elem(sol, x), y)
    {b2, s2} = case b1 do
      "T" -> {String.at(elem(board, x+1), y), String.at(elem(sol, x+1), y)}
      "B" -> {String.at(elem(board, x-1), y), String.at(elem(sol, x-1), y)}
      "L" -> {String.at(elem(board, x), y+1), String.at(elem(sol, x), y+1)}
      "R" -> {String.at(elem(board, x), y-1), String.at(elem(sol, x), y-1)}
    end
    {{s1, s2}, {b1, b2}}
  end

end
