package main

import (
	"fmt"
	"io/ioutil"
	"log"
)

func read() (string, error) {
	contents, err := ioutil.ReadFile("output.txt")
	return string(contents), err
}

func write(contents string) error {
	return ioutil.WriteFile("output.txt", []byte(contents), 0644)
}

func main() {
	err := write("file contents")
	if err != nil {
		log.Fatal(err)
	}
	contents, err := read()
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(contents)
}
