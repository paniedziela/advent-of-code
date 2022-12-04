import std/[strutils, strformat, sequtils, sets, math]

let data = readFile("input_2022_3.txt").strip().splitLines()
let lowercase = {'a'..'z'}.toSeq
let uppercase = lowercase.mapIt(it.toUpperAscii)
let letters = lowercase.concat(uppercase)
# part 1
let solution = data.mapIt(toHashSet(it[0..<(len(it) div 2)]).intersection(it[(
    len(it) div 2)..^1].toHashSet)).mapIt(letters.find(it.toSeq[0]) + 1).sum
echo &"Part 1: {solution}"
# part 2
let solution2 = data.distribute(data.len div 3).mapIt(it.mapIt(
    it.toHashSet).foldl(a.intersection(b))).mapIt(letters.find(it.toSeq[0]) + 1).sum
echo &"Part 2: {solution2}"
