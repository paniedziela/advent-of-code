import std/[strutils, strformat, strscans, sequtils, algorithm, re, enumerate]

# data preparation
let data = readFile("input_2022_5.txt").strip().split("\n\n", maxsplit = 1)
let drawing = data[0]
let procedure = data[1].splitLines()
let crates = drawing.splitLines().reversed()[1..^1].mapIt(it.findAll(
    re".{3}(\s|$)").mapIt(it.strip(chars = {' ', '[', ']'})))

# is there a cleaner way?
var cratesParsed = newSeq[seq[string]](crates[0].len)
for row in crates:
  for i, el in enumerate(row):
    if el != "":
      cratesParsed[i].add(el)
var cratesParsed2 = cratesParsed

var amount, source, destination: int
for line in procedure:
  if scanf(line, "move $i from $i to $i", amount, source, destination):
    # part 1
    for i in countup(1, amount):
      let element = pop(cratesParsed[source-1])
      cratesParsed[destination-1].add(element)
    # part 2
    let elements = cratesParsed2[source-1][^amount..^1]
    cratesParsed2[source-1] = cratesParsed2[source-1][0..^amount+1]
    cratesParsed2[destination-1].add(elements)
  else:
    echo &"Error parsing {line}"

let solution = cratesParsed.mapIt(it[^1]).join("")
let solution2 = cratesParsed2.mapIt(it[^1]).join("")
echo &"Part 1: {solution}"
echo &"Part 2: {solution2}"
