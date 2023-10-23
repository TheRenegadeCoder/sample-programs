function sleepSort(arr) {
  const sortedArray = [];

  function sleepSortHelper(item) {
    setTimeout(() => {
      sortedArray.push(item);
      if (sortedArray.length === arr.length) {
        console.log(sortedArray.join(", "));
      }
    }, item*1000);
  }

  arr.forEach((item) => {
    if (item < 0) {
      console.log(error_msg);
      return;
    }
    sleepSortHelper(item);
  });
}

const error_msg =
  'Usage: please provide a list of at least two integers to sort in the format "1, 2, 3, 4, 5"';

function sortNumbers(input) {
  const numberList = input.split(",").map((item) => parseInt(item.trim()));

  if (numberList.length < 2) {
    console.log(error_msg);
  } else if (numberList.some(isNaN)) {
    console.log(error_msg);
  } else {
    sleepSort(numberList);
  }
}

const input = process.argv[2];

if (!input) {
  console.log(error_msg);
} else {
  sortNumbers(input);
}
