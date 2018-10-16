(arr1, arr2) =>
  arr1.reduce((acc, element) =>
    (arr2.includes(element) ? acc : acc.concat(element)), []);
