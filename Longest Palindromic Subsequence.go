# Longest Palindromic Subsequence

func longestPalindromeSubseq(s string) int {
    mem := make([][]int, len(s))
    for i := range mem {
        mem[i] = make([]int, len(s))
    }
    return helper(0, len(s) - 1, &s, &mem)
}

func helper(l, r int, s *string, mem *[][]int) int {
    if l == r { return 1 }
    if l > r { return 0 }
    if (*mem)[l][r] != 0 { return (*mem)[l][r] }
    if (*s)[l] == (*s)[r] {
        (*mem)[l][r] = 2 + helper(l+1, r-1, s, mem)
    } else {
        (*mem)[l][r] = max(helper(l+1, r, s, mem), helper(l, r-1, s, mem))
    }
    return (*mem)[l][r]
}

func max(a, b int) int {
    if a > b { return a }
    return b
}
