var error_msg = "Usage: please enter the dimension of the matrix and the serialized matrix";
if (process.argv.length != 5) {
    console.log(error_msg);
    process.exit(1);
}
var cols = parseInt(process.argv[2]);
var rows = parseInt(process.argv[3]);
var list_str = process.argv[4];
if (isNaN(cols) || isNaN(rows) || list_str.length == 0) {
    console.log(error_msg);
    process.exit(1);
}
var list = list_str.split(",").map(function (x) { return parseInt(x); });
var matrix = [];
for (var i = 0; i < rows; i++) {
    matrix.push(list.slice(i * cols, (i + 1) * cols));
}
var transpose = [];
for (var i = 0; i < cols; i++) {
    transpose.push([]);
    for (var j = 0; j < rows; j++) {
        transpose[i].push(matrix[j][i]);
    }
}
console.log(transpose.map(function (x) { return x.join(", "); }).join(", "));
