#include <algorithm>
#include <array>
#include <charconv>
#include <cstdint>
#include <iostream>
#include <optional>
#include <string_view>

namespace Zeckendorf
{
constexpr auto generate_fibs() noexcept
{
    std::array<uint64_t, 92> arr{}; // 93rd overflows uint64_t
    arr[0] = 1;
    arr[1] = 2;
    for (size_t i = 2; i < arr.size(); ++i)
        arr[i] = arr[i - 1] + arr[i - 2];
    return arr;
}

static constexpr auto fibs = generate_fibs();

void print_representation(uint64_t n)
{
    if (n == 0)
    {
        std::cout << "\n";
        return;
    }

    // O(log N) lookup
    auto it = std::upper_bound(fibs.begin(), fibs.end(), n);
    bool first = true;

    while (it != fibs.begin())
    {
        --it;
        if (*it <= n)
        {
            std::cout << (first ? "" : ", ") << *it;
            n -= *it;
            first = false;
        }
    }
    std::cout << '\n';
}
} // namespace Zeckendorf

[[nodiscard]] std::optional<uint64_t> try_parse_arg(std::string_view s) noexcept
{
    if (s.empty() || s.front() == '-' || s.front() == '+')
        return std::nullopt;

    uint64_t value{};
    const auto [ptr, ec] =
        std::from_chars(s.data(), s.data() + s.size(), value);

    if (ec != std::errc{} || ptr != s.data() + s.size())
        return std::nullopt;

    return value;
}

void usage()
{
    std::cerr << "Usage: please input a non-negative integer\n";
}

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        usage();
        return EXIT_FAILURE;
    }

    if (auto value = try_parse_arg(argv[1]))
    {
        Zeckendorf::print_representation(*value);
        return EXIT_SUCCESS;
    }

    usage();
    return EXIT_FAILURE;
}