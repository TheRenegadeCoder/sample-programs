package main

 import (
         "fmt"
         "strings"
 )

 func longestLine(input string) (longest string) {
         lines := strings.Split(input, "\n")

         size := 0

         for _, v := range lines {
                 //fmt.Println(k,v, "Size: ", len(v))

                 if len(v) >= size {
                         longest = v
                         size = len(v)
                 }
         }
         return
 }

 func main() {
         text := `line 1
 line 2 line 3 line 4
 line 5 line 6 line 7 line 8 line 9 line 10
 line 11 line 12
 line 13 line 14 line 15`

         //fmt.Println(text)

         // find the longest line in text and display it
         fmt.Println("Longest: ", longestLine(text))
 }