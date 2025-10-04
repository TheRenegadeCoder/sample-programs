package main

import (
	"fmt"
	"math"
	"os"
	"regexp"
	"strconv"
)

type job struct {
	profit   int
	deadline int
}

type jobSequence []job
type jobMapping map[int]job

func maxProfit(jobs jobSequence) int {
	total := 0
	seq := iterateJobSequence(jobs, jobMapping{})
	for _, j := range seq {
		total += j.profit
	}
	return total
}

func iterateJobSequence(available jobSequence, complete jobMapping) jobMapping {
	if len(available) <= 0 {
		return complete
	}
	maxJob, available := available.popMax()
	if i := complete.newIndex(maxJob); i >= 0 {
		complete[i] = maxJob
	}
	return iterateJobSequence(available, complete)
}

func (mapping jobMapping) newIndex(maxJob job) int {
	var indexes []int
	for i := 0; i < maxJob.deadline; i++ {
		if _, ok := mapping[i]; !ok {
			indexes = append(indexes, i)
		}
	}
	if len(indexes) <= 0 {
		return -1
	}
	return indexes[len(indexes)-1]
}

func (seq jobSequence) popMax() (job, jobSequence) {
	max := job{math.MinInt32, math.MinInt32}
	maxI := -1
	for i, v := range seq {
		if v.profit > max.profit {
			max = v
			maxI = i
		}
	}
	return max, append(seq[:maxI], seq[maxI+1:]...)
}

func buildJobSequence(profits []int, deadlines []int) (jobs jobSequence) {
	for i, profit := range profits {
		newJob := job{profit: profit, deadline: deadlines[i]}
		jobs = append(jobs, newJob)
	}
	return
}

func exitWithError() {
	fmt.Println("Usage: please provide a list of profits and a list of deadlines")
	os.Exit(1)
}

func strToSliceInt(strList string) []int {
	list := regexp.MustCompile(", ?").Split(strList, -1)
	if len(list) < 2 {
		exitWithError()
	}
	var nums []int
	for _, num := range list {
		n, err := strconv.Atoi(num)
		if err != nil {
			exitWithError()
		}
		nums = append(nums, n)
	}
	return nums
}

func main() {
	if len(os.Args) != 3 {
		exitWithError()
	}

	profits := strToSliceInt(os.Args[1])
	deadlines := strToSliceInt(os.Args[2])
	if len(profits) != len(deadlines) {
		exitWithError()
	}
	jobs := buildJobSequence(profits, deadlines)
	max := maxProfit(jobs)
	fmt.Println(max)

}
