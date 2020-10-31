let num = Number(prompt("Enter a number"));
let prime = [];
let status = true;
for (let i = 2; i <= num; i++) {
    for (let j = 2; j < i; j++) {
        if ((i % j) == 0) {
            status = false;
            break;
        } else status = true;

    }
    if (status == true)
        prime.push(i);
}
document.write(`prime numbers uptill ${num} are ${prime}`);