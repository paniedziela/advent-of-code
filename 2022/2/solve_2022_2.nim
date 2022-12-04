import std/[strutils, strformat, sequtils, sugar, tables]

# 1 -> rock 2 -> paper 3 -> scissors
let winningConditions = {1: 3, 2: 1, 3: 2}.toTable

# part 1
proc checkOutcome(round: seq[int]): int =
  let elf = round[0]
  let me = round[1]
  if winningConditions[me] == elf:
    return 6 + me
  elif me == elf:
    return 3 + me
  else:
    return me

# part 2
proc makeOutcome(round: seq[int]): int =
  let elf = round[0]
  let me = round[1]
  if me == 3:
    for w, l in winningConditions.pairs:
      if elf == l:
        return 6 + w
  elif me == 2:
    return 3 + elf
  else:
    return winningConditions[elf]


let data = readFile("input_2022_2.txt").strip()
let dataReplaced = data.multiReplace([("A", "1"), ("B", "2"), ("C", "3"), ("X",
    "1"), ("Y", "2"), ("Z", "3")])
let rounds = dataReplaced.split("\n")
let roundsInt = rounds.map(r => r.splitWhitespace().map(x => parseInt(x)))
let roundsOutcome = roundsInt.mapIt(checkOutcome(it))
let solution = roundsOutcome.foldl(a + b)
echo &"Part 1: {solution}"
let roundsOutcome2 = roundsInt.mapIt(makeOutcome(it))
let solution2 = roundsOutcome2.foldl(a + b)
echo &"Part 2: {solution2}"
