# Polarity Puzzle Rules & Specifications

## Board Representation
- LR (left right) and TB (top bottom) repersent magent orientation, placing magnets as +- pairs on those orientations. 
- Numbers along the top and left indicate required **positive poles**.
- Numbers along the bottom and right indicate required **negative poles**.
- -1 in specs means no constraint for that polarity in that row/column.

## Magnet Placement Rules
- Positive and negative poles cannot be vertically or horizontally adjacent.
- Any number of magnets may be placed as long as constraints are met.
- Multiple solutions may exist; your program must return **one valid solution**.

## Input / Output Format
### Inputs
1. Top, Bottom, Left, Right constraints given as data structure ** specs**.
2. Board orientations (2D array of 'T', 'B', 'L', 'R')

### Output
- 2D array of strings: '+', '-', 'X' (X repersents no magnet)

### Smalltalk
- Class: `Polarity`
- Method: `solve: board with: specs`
- `specs`: Dictionary with keys `'left'`, `'right'`, `'top'`, `'bottom'` and arrays of integers
- `board`: Array of strings representing tile orientations
- Return: Array of strings containing `+`, `-`, `X`

### Elixir
- Function: `polarity(board, specs)` in `polarity.ex`
- `board`: Tuple of strings
- `specs`: Map of tuples with keys `"left"`, `"right"`, `"top"`, `"bottom"`  
  Example:
  ```elixir
  %{
    "left" => {2, 3, -1, -1, -1},
    "right" => {-1, -1, -1, 1, -1},
    "top" => {1, -1, -1, 2, 1, -1},
    "bottom" => {2, -1, -1, 2, -1, 3}
  }
Return: Tuple of strings (same format as board)

### Haskell
- Function: polarity :: [String] -> ([Int], [Int], [Int], [Int]) -> [String] in Polarity.hs
- board: List of strings
- specs: Tuple of lists of integers (left, right, top, bottom)
- Return: List of strings (solved board)

### Rust
- Function: fn polarity(board: &[&str], specs: &(Vec<i32>, Vec<i32>, Vec<i32>, Vec<i32>)) -> Vec<String> in main.rs
- board: Array of string slices (&[&str])
- specs: Tuple of vectors of i32 (left, right, top, bottom)
- Return: Vector of strings (solved board)
