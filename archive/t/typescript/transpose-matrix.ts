const error_msg: string = "Usage: please enter the dimension of the matrix and the serialized matrix";
if (process.argv.length != 5) {
    console.log(error_msg);
    process.exit(1);
}
const cols: number = parseInt(process.argv[2]);
const rows: number = parseInt(process.argv[3]);
const list_str: string = process.argv[4];
if (isNaN(cols) || isNaN(rows) || list_str.length == 0) {
    console.log(error_msg);
    process.exit(1);
}
const list: number[] = list_str.split(",").map(function (x: string) { return parseInt(x); });

const matrix: number[][] = [];
for (let i: number = 0; i < rows; i++) {
    matrix.push(list.slice(i * cols, (i + 1) * cols));
}
const transpose: number[][] = [];
for (let i: number = 0; i < cols; i++) {
    transpose.push([]);
    for (let j: number = 0; j < rows; j++) {
        transpose[i].push(matrix[j][i]);
    }
}
console.log(transpose.map(function (x: number[]) { return x.join(", "); }).join(", "));