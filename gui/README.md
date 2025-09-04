# **Polarity Puzzle GUI**
Purpose

This GUI was created to help me solve Polarity Puzzle boards by hand. When testing potential solutions, I wanted a way to quickly mark tiles and immediately see the effect on the board and the row/column specifications. Rather than building a fully automated solver, this tool allows manual experimentation, making it easier to verify solutions and understand board behavior.

Features

Interactive grid with clickable tiles.

Automatic updating of paired tiles (L/R and T/B).

Real-time updates of row/column specifications.

Undo functionality to revert the last move.

Easy customization for different boards and specs.

Usage

Run the script: python polarity_gui.py.

Click a cell to mark it as +; its paired tile will automatically be marked as -.

Click a + again to clear it (and paired - if present).

Use the "Undo" button to revert the last move.

Customization

Change the board variable for the layout.

Adjust the specs dictionary for top, bottom, left, and right constraints.

Notes

Designed for manual solution testing.

Keeps history to allow iterative experimentation.
