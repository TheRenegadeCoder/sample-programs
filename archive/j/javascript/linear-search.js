function LinSearch(arr = [], valToSearch) {
    let check = false;
    if (arr.length == 0) return check
    if(valToSearch==='') return check
    else {
        for (i = 0; i < arr.length; i++) {
            if (arr[i] == valToSearch){
                check = true
                return check
            }
        }
        return check
    }
}

sanitizeArray = (list) => {
    return list.split(',').map(e => {
       _e = parseInt(e.replace(" ",""));
       if (!_e){ throw new Error();}
       return _e;
    });
 }

const exit = () => {
     const usage = 'Usage: please provide a list of sorted integers ("1, 4, 5, 11, 12") and the integer to find ("11")';
     console.log(usage)
     process.exit();
 }
 
const main = (input, key) => {
    try {
        arr = sanitizeArray(input);
        arr.length < 1 || key == undefined ? exit() : console.log(LinSearch(arr, key));
    } catch(err) {
        exit();
    }
}

main(process.argv[2], process.argv[3])
