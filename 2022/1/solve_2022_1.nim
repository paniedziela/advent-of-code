import std/[strutils, strformat, sequtils, sugar, algorithm]
# part 1
let data = readFile("input_2022_1.txt").strip()
let elves = data.split("\n\n")
let elvesInt = elves.map(e => e.split("\n").map(i => parseInt(i)))
let elvesSum = elvesInt.map(e => e.foldl(a + b))
let solution = elvesSum.max()
echo &"Part 1: {solution}"

let oneLineSolution = readFile("input_2022_1.txt").strip().split("\n\n").map(
    e => e.split("\n").map(i => parseInt(i)).foldl(a + b)).max()
assert oneLineSolution == solution

# part 2
let n = 3
let solution2 = elvesSum.sorted(Descending)[0..n-1].foldl(a + b)
echo &"Part 2: {solution2}"
