# same as fizzbuzz_v1.ua, but trying to use planet notation

ReplaceMultipleWithWord ← (
  ⊙⊙⊃△∘               # take the shape of input array (bottom of stack)
  ⊃(⌈÷⊙⋅∘)(⊙⊙∘)       # rows = ceil(array shape / divisor); divisor is at top of stack
  ⊸⊂                  # join rows and divisor to make new shape, keeping last element (divisor)
  ⊃(⋅⊙⊙⊙◌)(↯⊙⋅⋅◌)     # reshape input array with new shape (top of stack). discard original input array and new shape
  ⊃(⋅⊙⊙◌)(≡↙(-1)⊙⋅⋅∘) # take divisor-1 (top of stack) elements per row. discard divisor (top of stack)
  ⊃(⋅⊙◌)(≡⊂:⊙◌)       # row-wise join, keeping the middle value (length of array)
  ↯                   # reshape
)

+1 ⇡100 # 1 to 100 inclusive
ReplaceMultipleWithWord 3 {"Fizz"}
ReplaceMultipleWithWord 5 {"Buzz"}
ReplaceMultipleWithWord ×5 3 {"FizzBuzz"}
