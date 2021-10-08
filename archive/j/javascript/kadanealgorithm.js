/**
 * @param {number[]} nums
 * @return {number}
 */
var maxSubArray = function(nums) {
    let maxtillnow = nums[0];
    let max = nums[0];

  for (let i = 1; i < nums.length; i++) {
    let current = nums[i];
    maxtillnow = Math.max(current, current + maxtillnow);
    max = Math.max(max, maxtillnow);
  }
  return max;
};