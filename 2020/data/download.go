package data

import (
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"paniedziela/aoc/utils"
	"path/filepath"
	"strings"
)

const cookieFilename = "aoc_cookies.txt"
const folder = "data"

func saveFile(year int, day int, resp *http.Response) {
	// alternative
	// body, err := ioutil.ReadAll(resp.Body)
	// body, err := io.ReadAll(resp.Body)
	// utils.HandleError(err)
	// data := string(body)
	fileName := fmt.Sprintf("input_%v_%v.txt", year, day)
	f, err := os.Create(filepath.Join(folder, fileName))
	utils.HandleError(err)
	defer f.Close()
	// status, err := f.ReadFrom(resp.Body)
	status, err := io.Copy(f, resp.Body)
	utils.HandleError(err)
	_ = status
	fmt.Printf("Downloaded and saved input: %v\n", fileName)
}

func getCookieToken() string {
	cwd, err := os.Getwd()
	utils.HandleError(err)
	cookieFile := filepath.Join(filepath.Dir(cwd), cookieFilename)
	cookieToken, err := os.ReadFile(cookieFile)
	utils.HandleError(err)
	return strings.TrimSpace(string(cookieToken))
}

func GetAocInput(year int, day int) {
	cookie := fmt.Sprintf("session=%v", getCookieToken())
	url := fmt.Sprintf("https://adventofcode.com/%v/day/%v/input", year, day)
	client := &http.Client{}
	req, err := http.NewRequest("GET", url, nil)
	utils.HandleError(err)
	req.Header.Add("Cookie", cookie)
	resp, err := client.Do(req)
	utils.HandleError(err)
	// VERY important note: if defer - don't wrap function in error handler
	// or at least "mine" utils.HandleError() -> "executes" immediately
	// "wasted" so much time...
	defer resp.Body.Close()
	// if not nested func call -> parse body here
	saveFile(year, day, resp)
}

func ReadAocInput(year int, day int) (inputData string, err error) {
	fileName := fmt.Sprintf("input_%v_%v.txt", year, day)
	inputFile := filepath.Join(folder, fileName)
	if _, err := os.Stat(inputFile); errors.Is(err, os.ErrNotExist) {
		return "", err
	}
	dataBytes, err := os.ReadFile(inputFile)
	return string(dataBytes), err
}
