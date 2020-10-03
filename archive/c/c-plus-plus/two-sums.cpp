#include <vector>
#include <unordered_map>
using namespace std;

// find the index of the first two numbers in a vector that add up to a target number
// example: nums = [1, 3, 2, 1], target = 3, solution = [0, 2] because nums[0] and nums[2] add to 3
class TwoSums {
  public:
    vector<int> twoSum(vector<int> &nums, int target) {
        unordered_map<int, int> index_by_num;
        for (int i = 0; i < nums.size(); i++) {
            int pair_index = target - nums[i];
            if (index_by_num.count(pair_index) != 0 && index_by_num[pair_index] != i) {
                vector<int> solution = {index_by_num[pair_index], i};
                return solution;
            }

            index_by_num[nums[i]] = i;
        }

        int i = nums.size() - 1;
        int pair_index = target - nums[i];
        if (index_by_num.count(pair_index) != 0 && index_by_num[pair_index] != i) {
            vector<int> solution = {index_by_num[pair_index], i};
            return solution;
        }

        return {};
    }
};