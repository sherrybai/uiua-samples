N ← 3 # board size

CheckRowsColsForWin ← (
  ⊃(/↥/+|/↥≡/+) # max sum of rows, max sum of columns
  ↥             # maximum across all categories
  =N            # return if any value is 3
)

CheckDiagonalsForWin ← (
  ♭
  # left diagonal: checking index 0, 4, 8
  # right diagonal: checking index 2, 4, 6
  ⊃(/+⊏(×(+1 N) ⇡N))(/+⊏(+(-1 N)×(-1 N)⇡N))
  ↥
  =N
)

X                 ← 1
O                 ← 2
PlayX             ← ⍜⊡(X◌)
PlayO             ← ⍜⊡(O◌)
CheckForPlayerWin ← ↥⊃(CheckRowsColsForWin)(CheckDiagonalsForWin)
CheckGameIsOver   ← ≠0 /↧/↧ # no empty spaces
CheckForWin       ← |1 /↥[⊃(CheckForPlayerWin =X|CheckForPlayerWin =O|⊙◌ CheckGameIsOver .)]

# read and parse indices from standard input
ParsePositionFromStdin ← (
  ⊜□⊸≠@, &sc         # split by ,
  -@0                # digits to integers
  ≡(/+ × ⁿ:10 ⇌°⊏°□) # unbox each item and multiply each digit by appropriate power of 10
)

PositionIsValid ← (
  /↧↧⊃(<N|≥0|∘)            # all values have to be within [0, N)
  ⨬(0⊙⊙∘|⊃(⋅(=0⊡))(⊙⊙∘)) . # if within bounds, space has to be empty
  ↧                        # AND both values
)

# whose turn is it?
# randomly select between X=1 or O=2
+1 ⌊×2 ⚂

# new board
↯[N N] 0

# loop until someone wins
⍢(
  ⊃(⋅(&pf ⨬("X"|"O") -1))(⊙∘) # whose turn is 2 places back in the stack
  &p " to play"
  ParsePositionFromStdin
  ⨬(&p "Invalid move" ⋅⊙∘               # if move is invalid, print error message and pop off bad move
  | ⨬(PlayX|PlayO) ⊃(⋅⋅(-1))(⊙⊙(+1 ◿2)) # play based on current turn and then update the turn in place
  ) PositionIsValid
  &s ↯[N N]⨬({"_"}|{"X"}|{"O"}) . # print a formatted representation of the board
)(¬CheckForWin .)

# print who won
&pf⨬("Nobody"|"X"|"O")(+⊙(×2)⊃(CheckForPlayerWin =X)(CheckForPlayerWin =O))
&p " wins!"

# avoid displaying turn when program exits
◌
