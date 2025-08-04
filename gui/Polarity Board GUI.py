import tkinter as tk
import copy

# Initial data
board = [
    'TTLR', 
    'BBLR', 
    'LRTT', 
    'LRBB' 
]

specs = {
    "top":    [1, 1, -1, 1],
    "bottom": [1, 1, 0, 2],
    "left":   [0, 1, 2, -1],
    "right":  [0, -1, 1, 2]
}

board_height = len(board)
board_width = len(board[0])

current_specs = {
    "top": specs["top"][:],
    "bottom": specs["bottom"][:],
    "left": specs["left"][:],
    "right": specs["right"][:]
}

root = tk.Tk()
root.title("Polarity Board")

buttons = []
board_state = [["" for _ in range(board_width)] for _ in range(board_height)]
spec_labels = {"top": [], "bottom": [], "left": [], "right": []}
history = []

def find_paired_cell(row, col):
    tile = board[row][col]
    if tile == "L" and col + 1 < board_width and board[row][col + 1] == "R":
        return row, col + 1
    elif tile == "R" and col - 1 >= 0 and board[row][col - 1] == "L":
        return row, col - 1
    elif tile == "T" and row + 1 < board_height and board[row + 1][col] == "B":
        return row + 1, col
    elif tile == "B" and row - 1 >= 0 and board[row - 1][col] == "T":
        return row - 1, col
    return None

def recalc_and_update_specs():
    for side in ["top", "bottom", "left", "right"]:
        current_specs[side] = specs[side][:]

    for r in range(board_height):
        plus_in_row = sum(1 for c in range(board_width) if board_state[r][c] == "+")
        minus_in_row = sum(1 for c in range(board_width) if board_state[r][c] == "-")
        if specs["left"][r] != -1:
            current_specs["left"][r] = max(0, specs["left"][r] - plus_in_row)
        if specs["right"][r] != -1:
            current_specs["right"][r] = max(0, specs["right"][r] - minus_in_row)

    for c in range(board_width):
        plus_in_col = sum(1 for r in range(board_height) if board_state[r][c] == "+")
        minus_in_col = sum(1 for r in range(board_height) if board_state[r][c] == "-")
        if specs["top"][c] != -1:
            current_specs["top"][c] = max(0, specs["top"][c] - plus_in_col)
        if specs["bottom"][c] != -1:
            current_specs["bottom"][c] = max(0, specs["bottom"][c] - minus_in_col)

    for idx in range(board_width):
        if specs["top"][idx] != -1:
            spec_labels["top"][idx].config(text=str(current_specs["top"][idx]))
        if specs["bottom"][idx] != -1:
            spec_labels["bottom"][idx].config(text=str(current_specs["bottom"][idx]))

    for idx in range(board_height):
        if specs["left"][idx] != -1:
            spec_labels["left"][idx].config(text=str(current_specs["left"][idx]))
        if specs["right"][idx] != -1:
            spec_labels["right"][idx].config(text=str(current_specs["right"][idx]))

def update_buttons_and_colors():
    for r in range(board_height):
        for c in range(board_width):
            piece = board_state[r][c]
            base = board[r][c]
            display = piece if piece else base
            buttons[r][c].config(text=display)
            if piece == "+":
                buttons[r][c].config(bg="lightgreen", fg="black")
            elif piece == "-":
                buttons[r][c].config(bg="lightcoral", fg="black")
            else:
                buttons[r][c].config(bg="SystemButtonFace", fg="black")

def on_cell_click(row, col):
    history.append(copy.deepcopy(board_state))
    current = board_state[row][col]
    if current == "+":
        board_state[row][col] = ""
        paired = find_paired_cell(row, col)
        if paired:
            pr, pc = paired
            if board_state[pr][pc] == "-":
                board_state[pr][pc] = ""
    else:
        board_state[row][col] = "+"
        paired = find_paired_cell(row, col)
        if paired:
            pr, pc = paired
            board_state[pr][pc] = "-"
    update_buttons_and_colors()
    recalc_and_update_specs()

def undo_move():
    if history:
        prev_state = history.pop()
        for r in range(board_height):
            for c in range(board_width):
                board_state[r][c] = prev_state[r][c]
        update_buttons_and_colors()
        recalc_and_update_specs()

# Top spec labels
for col, val in enumerate(specs["top"]):
    text = "" if val == -1 else str(val)
    label = tk.Label(root, text=text, font=("Helvetica", 12, "bold"))
    label.grid(row=0, column=col+1, padx=5, pady=5)
    spec_labels["top"].append(label)

# Bottom spec labels
for col, val in enumerate(specs["bottom"]):
    text = "" if val == -1 else str(val)
    label = tk.Label(root, text=text, font=("Helvetica", 12, "bold"))
    label.grid(row=board_height+1, column=col+1, padx=5, pady=5)
    spec_labels["bottom"].append(label)

# Left and right spec labels
for row in range(board_height):
    lval = "" if specs["left"][row] == -1 else str(specs["left"][row])
    llabel = tk.Label(root, text=lval, font=("Helvetica", 12, "bold"))
    llabel.grid(row=row+1, column=0, padx=5, pady=5)
    spec_labels["left"].append(llabel)

    rval = "" if specs["right"][row] == -1 else str(specs["right"][row])
    rlabel = tk.Label(root, text=rval, font=("Helvetica", 12, "bold"))
    rlabel.grid(row=row+1, column=board_width+1, padx=5, pady=5)
    spec_labels["right"].append(rlabel)

# Buttons with tile letters
for i in range(board_height):
    row_buttons = []
    for j in range(board_width):
        brdletter = board[i][j]
        btn = tk.Button(
            root,
            text=brdletter,
            width=6,
            height=3,
            font=("Helvetica", 12),
            command=lambda r=i, c=j: on_cell_click(r, c)
        )
        btn.grid(row=i+1, column=j+1)
        row_buttons.append(btn)
    buttons.append(row_buttons)

# Undo button below the grid
undo_btn = tk.Button(root, text="Undo", command=undo_move, font=("Helvetica", 12, "bold"))
undo_btn.grid(row=board_height+2, column=board_width//2, columnspan=2, pady=10)

root.mainloop()

# too lazy to comment this part out, but this was my original board and specs, so moved it here for reference
board = [
    "LRTTLRTT",
    "LRBBLRBB",
    "TTLRTTLR",
    "BBLRBBLR",
    "LRTTLRTT",
    "LRBBLRBB",
    "TTLRTTLR",
    "BBLRBBLR"
]

specs = {
    "top":    [0, 4, 3, 3, -1, 3, -1, 1],
    "bottom": [2, 2, 3, 3, 2, -1, 1, 3],
    "left":   [-1, -1, 2, 2, 4, -1, 3, 2],
    "right":  [-1, 1, -1, 3, 3, -1, -1, 4]
}