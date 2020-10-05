/**
 * Job Sequencing with deadlines
 */

class Job{
  constructor(profit, deadline){
    this.profit = profit;
    this.deadline = deadline;
  }
}

/* Function to create an array of Job objects */
const createJobs = (array1, array2) => {
  let addedJobs = [];
  for(let index=0; index<array1.length; index++){
    addedJobs.push(new Job(array1[index], array2[index]));
  }
  return addedJobs;
}

/* Sort Jobs based on profit in descending order */
const sortJobs = (jobs) => jobs.sort((a,b) => {
  if(a.profit > b.profit){
    return -1;
  }else if(a.profit > b.profit){
    return 1;
  }else{
    return 0;
  }
});

/* Function to find the maximum deadline to limit the total time slot */
const findMaxDeadline = (jobs) => {
  let maxDeadline = 0;
  for(let index = 0; index<jobs.length; index++){
    maxDeadline = Math.max(jobs[index].deadline, maxDeadline);
  }
  return maxDeadline;
}

/* Function to find the maximum profit */
const findMaxProfit = (jobs, maxDeadline) => {
  let jobSlotsFull = Array(maxDeadline).fill(false);
  let maxProfit = 0;
  let count=0;
  for(let index=0; index < jobs.length; index++){
    if(count === maxDeadline){
      break;
    }
    let deadline = jobs[index].deadline;
    if(deadline > maxDeadline){
      continue;
    }
    for(let slotIndex = deadline-1; slotIndex >= 0; slotIndex--){
      if(jobSlotsFull[slotIndex] === false){
        maxProfit += jobs[index].profit;
        jobSlotsFull[slotIndex] = true;
        count++;
        break;
      }
    }
  }
  return maxProfit;
}

/* Function to split strings into arrays */
const splitString = (str) => str.split(',').map(each => parseInt(each.trim(),10));

/* Function to check the validity of the number arrays */
const checkValidity = (array1, array2) => {
  if(array1.some(isNaN) || 
      array2.some(isNaN) ||
      array1.length != array2.length){
        throw new Error();
    }
}

/* Function to exit in case of invalid input */
const exit = () => {
  const USAGE = "Usage: please provide a list of profits and a list of deadlines";
  console.log(USAGE);
}

/* Main Function */
const main = (string1, string2) => {
  try{
    const array1  = splitString(string1);
    const array2  = splitString(string2);
    checkValidity(array1, array2);
    let jobs = createJobs(array1, array2);
    jobs = sortJobs(jobs);
    let maxDeadline = findMaxDeadline(jobs);
    console.log(findMaxProfit(jobs, maxDeadline));
  }
  catch(err){
    exit();
  }
}

main(process.argv[2], process.argv[3])