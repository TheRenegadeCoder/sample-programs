package main

import (
	"encoding/base64"
	"fmt"
	"os"
)

func die() {
	fmt.Println("Usage: please provide a mode and a string to encode/decode")
	os.Exit(1)
}

func main() {
	if len(os.Args) < 3 {
		die()
	}

	enc := base64.StdEncoding

	if len(os.Args[2]) == 0 {
		die()
	}

	switch os.Args[1] {
	case "encode":
		fmt.Println(enc.EncodeToString([]byte(os.Args[2])))
		return
	case "decode":
		s, err := enc.DecodeString(os.Args[2])
		if err != nil {
			die()
		}

		fmt.Println(string(s))
	default:
		die()
	}
}
