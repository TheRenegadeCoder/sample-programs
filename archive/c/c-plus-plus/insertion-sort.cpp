#include <iostream>
#include <vector>
#include <string>
#include <sstream>

void insertSort(std::vector<int> &v)
{
    int n = v.size();
    int i = 0, j = 0, temp = 0;
    for (i = 1; i < n; i++)
    {
        int store = v[i];
        j = i - 1;
        while (store < v[j] && j >= 0)
        {
            v[j + 1] = v[j];
            j--;
        }
        v[j + 1] = store;
    }
    return;
}

int main(int argc, char *argv[])
{
    std::vector<int> numbers;

    if (argc != 2)
    {
        std::cout << "Usage: please provide a list of at least two "
                     "integers to sort in the format \"1, 2, 3, 4, 5\""
                  << std::endl;
        return 1;
    }

    std::string str = argv[1];
    int i = 0, num = 0;
    if (str.size() < 2)
    {
        std::cout << "Usage: please provide a list of at least two "
                     "integers to sort in the format \"1, 2, 3, 4, 5\""
                  << std::endl;
        return 1;
    }

    std::stringstream ss(str);
    while (ss >> num)
    {
        numbers.push_back(num);

        if (ss.peek() == ',')
        {
            ss.ignore();
            ss.ignore();
        }

        else if (ss.tellg() != -1)
        {
            std::cout << "Usage: please provide a list of at least two "
                         "integers to sort in the format \"1, 2, 3, 4, 5\""
                      << std::endl;
            return 1;
        }
    }

    insertSort(numbers);

    for (i = 0; i < numbers.size() - 1; i++)
    {
        std::cout << numbers[i] << ", ";
    }
    std::cout << numbers[i] << std::endl;
    return 0;
}
