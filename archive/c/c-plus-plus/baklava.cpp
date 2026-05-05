#include <cmath>
#include <iostream>
#include <ranges>
#include <string>

int main() {
    constexpr int n = 21;
    constexpr int mid = n / 2;

    for (int i : std::views::iota(-mid, mid + 1)) {
        int stars = n - 2 * std::abs(i);
        int spaces = std::abs(i);

        std::cout << std::string(spaces, ' ') << std::string(stars, '*')
                  << '\n';
    }
}