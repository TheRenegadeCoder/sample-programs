from typing import List

# without binary search
# time complexity: O(n + m)
# space complexity: O(1)

class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        n = len(matrix)
        m = len(matrix[0])

        # Start from the top-right corner
        row, col = 0, m - 1

        while row < n and col >= 0:
            if matrix[row][col] == target:
                return True
            elif matrix[row][col] > target:
                col -= 1  # move left
            else:
                row += 1  # move down

        return False


if __name__ == "__main__":
    # Example usage
    matrix = [
        [1, 3, 5, 7],
        [10, 11, 16, 20],
        [23, 30, 34, 60]
    ]
    target = 16

    sol = Solution()
    print(sol.searchMatrix(matrix, target))  # Output: True



# with binary search
# time complexity: O(log(n * m))
# space complexity: O(1)
class Solution:
    def searchMatrix(self, matrix: List[List[int]], target: int) -> bool:
        n = len(matrix)
        m = len(matrix[0])
        low = 0
        high = (n * m) - 1

        while low <= high:
            mid = (low + high) // 2
            row = mid // m
            col = mid % m

            if matrix[row][col] == target:
                return True
            elif matrix[row][col] < target:
                low = mid + 1
            else:
                high = mid - 1

        return False


if __name__ == "__main__":
    # Example usage
    matrix = [
        [1, 3, 5, 7],
        [10, 11, 16, 20],
        [23, 30, 34, 60]
    ]
    target = 3

    sol = Solution()
    print(sol.searchMatrix(matrix, target))  # Output: True
