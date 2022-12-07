package solutions

import (
	"fmt"
	"paniedziela/aoc/utils"
	"strconv"
	"strings"
)

func prepareInput(inputData string) []int {
	lines := strings.Split(strings.TrimSpace(inputData), "\n")
	values := make([]int, len(lines))
	for i, s := range lines {
		temp, err := strconv.Atoi(s)
		values[i] = temp
		utils.HandleError(err)
	}
	return values
}

func findValue(array []int, valueToFind int) bool {
	// no python-like "v in lines", found comment:
	// "That's what people mean when they say that Go doesn't have generics"
	valueFound := false
	for _, element := range array {
		if valueToFind == element {
			valueFound = true
			break
		}
	}
	return valueFound
}

// I don't like this solution (what if there were more numbers to find -> more loops?)
// from what I've seen, combinations is a good approach (so maybe the solution isn't that bad)
func solvePart2(values []int, value int) int {
	for i, v := range values {
		vTemp := value - v
		for j, v2 := range values[i:] {
			vToFind := vTemp - v2
			vFound := findValue(values[j:], vToFind)
			if vFound {
				return v * v2 * vToFind
			}
		}
	}
	fmt.Println("Value not found")
	return 0
}

func solvePart1(values []int, value int) int {
	for i, v := range values {
		vToFind := value - v
		vFound := findValue(values[i:], vToFind)
		if vFound {
			return v * vToFind
		}
	}
	fmt.Println("Value not found")
	return 0
}

// 2SUM and 3SUM problem?
// use map?
func SolveDay1Year2020(inputData string) {
	value := 2020
	values := prepareInput(inputData)
	solution1 := solvePart1(values, value)
	fmt.Printf("Part 1: %v\n", solution1)
	solution2 := solvePart2(values, value)
	fmt.Printf("Part 2: %v\n", solution2)
}
