#include <iostream>
#include <sstream>
#include <vector>
#include <limits>
#include <string>

void print_usage()
{
    std::cout << "Usage: Please provide a list of integers in the format: \"1, 2, 3, 4, 5\"\n";
}

int max_subarray_sum(const std::vector<int> &arr)
{
    int max_so_far = std::numeric_limits<int>::min();
    int max_ending_here = 0;

    for (int num : arr)
    {
        max_ending_here += num;

        if (max_so_far < max_ending_here)
        {
            max_so_far = max_ending_here;
        }

        if (max_ending_here < 0)
        {
            max_ending_here = 0;
        }
    }

    return max_so_far;
}

int main(int argc, char *argv[])
{
    if (argc < 2 || std::string(argv[1]).empty())
    {
        print_usage();
        return 1;
    }

    // Parse input string
    std::vector<int> arr;
    std::string input = argv[1];
    std::stringstream ss(input);
    std::string token;

    while (std::getline(ss, token, ','))
    {
        arr.push_back(std::stoi(token));
    }

    // If less than two integers were provided
    if (arr.size() == 1)
    {
        std::cout << arr[0] << "\n";
        return 0;
    }
    else if (arr.empty())
    {
        print_usage();
        return 1;
    }

    // Calculate maximum subarray sum
    int result = max_subarray_sum(arr);

    std::cout << result << "\n";

    return 0;
}
