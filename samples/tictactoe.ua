N ← 3 # board size

CheckRowsColsForWin ← (
  [⊃(/↥/+|/↥≡/+)] # max sum of rows, max sum of columns
  /↥              # maximum across all categories
  =N              # return if any value is 3
)

CheckDiagonalsForWin ← (
  ♭
  # left diagonal: checking index 0, 4, 8
  # right diagonal: checking index 2, 4, 6
  [⊃(/+⊏(×(+1 N) ⇡N))(/+⊏(+(-1 N)×(-1 N)⇡N))]
  /↥
  =N
)

X                 ← 1
O                 ← 2
PlayX             ← ⍜⊡(X◌)
PlayO             ← ⍜⊡(O◌)
CheckForPlayerWin ← ↥⊃(CheckRowsColsForWin)(CheckDiagonalsForWin)
CheckForWin       ← ↥⊃(CheckForPlayerWin =X|CheckForPlayerWin =O)

# read and parse indices from standard input
ParsePositionFromStdin ← (
  ⊜□⊸≠@, &sc # split by ,
  -@0        # digits to integers
  ∵(⇌°⊏°□)   # unbox each item and create array of exponents [..., 2, 1, 0]
  ≡/+ × ⁿ:10 # multiply each digit by appropriate power of 10
)

# whose turn is it?
X

# new board
↯[N N] 0

# loop until someone wins
⍢(
  ⊃(⋅(&pf ⨬("X"|"O") -1))(⊙∘) # whose turn is 2 places back in the stack
  &p " to play"
  ParsePositionFromStdin
  ⨬(PlayX|PlayO) ⊃(⋅⋅(-1))(⊙⊙(+1 ◿2)) # play based on current turn and then update the turn in place
  ⊃(&s ↯[N N]⨬({"_"}|{"X"}|{"0"}))(∘) # print a formatted representation of the board
)(¬CheckForWin .)

# print who won
&pf ⨬("X"|"O")(CheckForPlayerWin =O)
&p " wins!"

# avoid displaying turn when program exits
◌
