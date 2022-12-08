import std/[strutils, strformat, sequtils, math, algorithm]

proc checkVisibility(data: seq[seq[int]], x: int, y: int): bool =
  let element = data[x][y]
  var isVisible = false
  var column: seq[int]
  for i, row in data:
    if i == x:
      if row[0..<y].max < element or row[y+1..^1].max < element:
        isVisible = true
        break
      isVisible = false
    for j, el in row:
      if j == y:
        column.add(el)
        break
  if not isVisible:
    if column[0..<x].max < element or column[x+1..^1].max < element:
      isVisible = true
  return isVisible

proc getVisibleTrees(data: seq[seq[int]]): int =
  let numRows = data.len
  let numCols = data[0].len
  var visibilityMap = newSeqWith(numRows, newSeq[bool](numCols))
  for i, row in data:
    if i == 0 or i == numRows - 1:
      visibilityMap[i] = repeat(true, numCols)
      continue
    for j, el in row:
      if j == 0 or j == numCols - 1:
        visibilityMap[i][j] = true
      else:
        visibilityMap[i][j] = checkVisibility(data, i, j)
  return visibilityMap.mapIt(it.count(true)).sum

proc parse(data: seq[int], element: int, reverse: bool): int =
  let dataProc = if reverse: data.reversed else: data
  var score = 0
  # score will be at least 1
  for item in dataProc:
    if item >= element:
      score += 1
      break
    score += 1
  return score

proc checkScenicScore(data: seq[seq[int]], x: int, y: int): int =
  let element = data[x][y]
  # neutral element for multiplication
  var scenicScore = 1
  var column: seq[int]
  # echo &"Parsing: {element} at {x} {y}"
  for i, row in data:
    if i == x:
      # parse left row[0..<y]
      let resLeft = parse(row[0..<y], element, reverse = true)
      scenicScore *= resLeft
      let resRight = parse(row[y+1..^1], element, reverse = false)
      # parse right row[y+1..^1]
      scenicScore *= resRight
      # echo &"LR {resLeft} {resRight}"
    for j, el in row:
      if j == y:
        column.add(el)
        break
  # parse up column[0..<x]
  let resUp = parse(column[0..<x], element, reverse = true)
  scenicScore *= resUp
  # parse down column[x+1..^1]
  let resDown = parse(column[x+1..^1], element, reverse = false)
  # echo &"UD {resUp} {resDown}"
  scenicScore *= resDown
  return scenicScore

proc getScenicScore(data: seq[seq[int]]): int =
  let numRows = data.len
  let numCols = data[0].len
  var scenicMap = newSeqWith(numRows, newSeq[int](numCols))
  for i, row in data:
    if i == 0 or i == numRows - 1:
      scenicMap[i] = repeat(0, numCols)
      continue
    for j, el in row:
      if j == 0 or j == numCols - 1:
        scenicMap[i][j] = 0
      else:
        scenicMap[i][j] = checkScenicScore(data, i, j)
  # for row in scenicMap:
  #   echo row
  return scenicMap.mapIt(it.max).max

# data preparation
let inputData = readFile("input_2022_8.txt")
let data = inputData.strip().splitLines().mapIt(
    it.toSeq.mapIt(parseInt($it)))

# part 1
let solution = getVisibleTrees(data)
# part 2
let solution2 = getScenicScore(data)

echo &"Part 1: {solution}"
echo &"Part 2: {solution2}"
