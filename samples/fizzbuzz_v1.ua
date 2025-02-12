# first attempt at writing FizzBuzz

ReplaceMultipleWithWord ← (
  ⊙△ ⊙. ⊙: # duplicate input array and get shape
  ⌈ ◡÷     # get rows by dividing shape by divisor. keep shape and divisor on stack underneath rows
  ⊂        # new shape [rows, divisor]
  ⊙:       # reorder to bring input array to front
  ⟜↯       # reshape by [rows, divisor], keeping new shape on the top
  ≡↙ -1 ⊣  # take all but the last item in each row
  ⊙:       # reorder to bring replacement word to front
  ≡⊂       # append replacement word to the end
  ↯:       # bring original shape back to front and reshape
)

+1 ⇡100 # 1 to 100 inclusive
ReplaceMultipleWithWord 3 {"Fizz"}
ReplaceMultipleWithWord 5 {"Buzz"}
ReplaceMultipleWithWord ×5 3 {"FizzBuzz"}
