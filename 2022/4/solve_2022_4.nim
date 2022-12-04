import std/[strutils, strformat, sequtils]

let data = readFile("input_2022_4.txt").strip().splitLines()
echo data.len
let solution = data.mapIt(it.split(",").mapIt(it.split("-").mapIt(
    it.parseInt))).filterIt((it[0][0] <= it[1][0] and it[0][1] >= it[1][1]) or (
    it[1][0] <= it[0][0] and it[1][1] >= it[0][1]))
echo &"Part 1: {solution.len}"
let solution2 = data.mapIt(it.split(",").mapIt(it.split("-").mapIt(
    it.parseInt))).filterIt(max(it[0][0], it[1][0]) <= min(it[0][1], it[1][1]))
echo &"Part 2: {solution2.len}"

