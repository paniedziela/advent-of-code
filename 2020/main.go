package main

import (
	"flag"
	"fmt"
	"paniedziela/aoc/data"
	"paniedziela/aoc/solutions"
	"paniedziela/aoc/utils"
)

func main() {
	var year int
	var day int
	var solve bool
	// this flag package is pretty bad...
	// e.g. no required or skip default, no short and long options
	flag.IntVar(&year, "y", 2020, "Year")
	flag.IntVar(&day, "d", 1, "Day")
	flag.BoolVar(&solve, "s", false, "Set to solve puzzle or else download input file")
	flag.Parse()
	if solve {
		fmt.Printf("Solving puzzle for year: %v day: %v\n", year, day)
		inputData, err := data.ReadAocInput(year, day)
		utils.HandleError(err)
		switch year {
		case 2020:
			switch day {
			case 1:
				solutions.SolveDay1Year2020(inputData)
			default:
				fmt.Printf("Day %v of year %v is not solved yet", day, year)
			}
		default:
			fmt.Printf("Year %v has no solutions yet", year)
		}
	} else {
		fmt.Printf("Downloading input file for year: %v day: %v\n", year, day)
		data.GetAocInput(year, day)
	}
}
