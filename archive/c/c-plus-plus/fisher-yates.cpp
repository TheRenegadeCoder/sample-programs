#include <cstdlib>
#include <algorithm>
#include <vector>
#include <iostream>

template <typename T>
void shuffle(std::vector<T> &vec)
{
    for (int i = vec.size() - 1; i > 0; --i)
    {
        int j = rand() % (i + 1);
        std::swap(vec[i], vec[j]);
    }
}

template <typename T>
void print_vector(std::vector<T> &vec)
{
    for (auto elem : vec)
    {
        std::cout << elem << " ";
    }
    std::cout << std::endl;
}

int main()
{
    auto v = std::vector<int> { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    print_vector(v);

    shuffle(v);

    print_vector(v);

    return 0;
}
