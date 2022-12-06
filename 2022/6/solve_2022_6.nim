import std/[strutils, strformat, sets, sequtils]

proc getNumChars(data: seq[char], startPacketLength: int): int =
  var numChars: int
  for i in countup(startPacketLength, data.len-1):
    numChars = i
    if data[i-startPacketLength..<i].toHashSet.len == startPacketLength:
      break
  result = numChars

# data preparation
let data = readFile("input_2022_6.txt").strip().toSeq()
# part 1
let solution = getNumChars(data, 4)
# part 2
let solution2 = getNumChars(data, 14)

echo &"Part 1: {solution}"
echo &"Part 2: {solution2}"
