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

### Smalltalk Specific
- Class: `Polarity`
- Method: `solve: board with: specs`
- `specs` is a Dictionary:  
