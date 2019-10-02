function formatSum(sum) {
    var beforeDot = /[^.]*/.exec(sum)[0]
    var afterDot = /(?<=\.).*/.exec(sum)[0]

    if (Number.isInteger(sum)) {
        return sum
    };
  
    return beforeDot + ','  + afterDot
}