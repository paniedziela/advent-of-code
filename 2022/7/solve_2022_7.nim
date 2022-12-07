import std/[strutils, strformat, sequtils, tables, math]

# Note: tried to use recursion, but failed
# (would work if I relied on mutable data and poping "visited" lines)
# inspiration: https://github.com/MichalMarsalek/Advent-of-code/blob/master/2022/Nim/day7.nim
# specifically: while loop at the end (forgot) + sort of addRemainingSize function

proc addRemainingSize(path: var seq[string], pathSizes: var Table[seq[string], int]) =
  # when going up a directory, save current path size, "pop" it and add to parent
  let pathSize = pathSizes[path]
  discard path.pop()
  pathSizes[path] += pathSize

let data = readFile("input_2022_7.txt").strip().splitLines().mapIt(
    it.splitWhitespace)

var pathSizes: Table[seq[string], int]
var path: seq[string]
for line in data:
  case line[0]:
    of "dir":
      continue
    of "$":
      case line[1]:
        of "ls":
          continue
        of "cd":
          if line[2] == "..":
            addRemainingSize(path, pathSizes)
          else:
            path.add(line[2])
            pathSizes[path] = 0
    else:
      pathSizes[path] += parseInt(line[0])
while path.len > 1:
  addRemainingSize(path, pathSizes)

let values = pathSizes.values.toSeq
let solution = values.filterIt(it <= 100000).sum
# values.max is the root directory
let solution2 = values.filterIt(70000000 - values.max + it >= 30000000).min
echo &"Part 1: {solution}"
echo &"Part 2: {solution2}"
