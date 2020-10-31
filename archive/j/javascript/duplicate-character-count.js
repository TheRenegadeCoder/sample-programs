function duplicateCharCount(str) {
  const charCount = str.split("").reduce((currentResult, currentChar) => ({
    ...currentResult,
    [currentChar]: (currentResult[currentChar] || 0)+1
  }), {})

  const result = Object.fromEntries(Object.entries(charCount).filter(([_,value]) => value > 1))

  console.log(result)
}


duplicateCharCount('goodbyeblues')