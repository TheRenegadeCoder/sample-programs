import sys
from typing import List


def error_handling(argv: List) -> List[int]:
    str_input = (','.join(i for i in argv[1:])).strip()
    if str_input == "":
        print('Usage: Please provide a list of integers in the format: "1, 2, 3, 4, 5"')
        sys.exit(1)
    nums = [int(num) for num in str_input.split(',')]
    return nums


def maximum_subarray(nums: List[int]) -> int:
    local_max = 0
    global_max = nums[0]
    for num in nums:
        local_max += num
        if (local_max < 0):
            local_max = 0
        elif global_max < local_max:
            global_max = local_max
    return global_max


if __name__ == "__main__":
    nums = error_handling(sys.argv)
    print(maximum_subarray(nums))
