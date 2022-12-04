import os
import std/[httpclient, strformat, strutils]

let args = commandLineParams()
let appName = getAppFilename()
if args.len != 2:
  echo &"Need year and day to get input: {app_name} <year> <day>"
else:
  let year = args[0]
  let day = args[1]
  let cookies = readFile(getCurrentDir() /../ "aoc_cookies.txt").strip()
  var client = newHttpClient()
  client.headers = newHttpHeaders({"Cookie": &"session={cookies}"})
  let data = client.getContent(&"https://adventofcode.com/{year}/day/{day}/input")
  createDir(day)
  writeFile(day / &"input_{year}_{day}.txt", data)
