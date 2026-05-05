#include <algorithm>
#include <cctype>
#include <charconv>
#include <iostream>
#include <optional>
#include <ranges>
#include <string>
#include <string_view>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

struct Job {
    int profit{};
    int deadline{};
};

struct DSU {
    std::vector<int> parent;

    explicit DSU(int n) : parent(n + 1) {
        for (int i = 0; i <= n; ++i) parent[i] = i;
    }

    int find(int x) {
        if (x == parent[x]) return x;
        return parent[x] = find(parent[x]);
    }

    void occupy(int slot) { parent[slot] = find(slot - 1); }
};

[[noreturn]] void usage() {
    std::cerr
        << "Usage: please provide a list of profits and a list of deadlines\n";
    std::exit(1);
}

static constexpr std::string_view ws = " \t\n\r\f\v";
constexpr std::string_view trim(std::string_view s) {
    const auto start = s.find_first_not_of(ws);
    if (start == std::string_view::npos) return "";
    s.remove_prefix(start);

    const auto end = s.find_last_not_of(ws);
    s.remove_suffix(s.size() - 1 - end);
    return s;
}

std::optional<int> to_int(std::string_view s) {
    int value{};
    auto [ptr, ec] = std::from_chars(s.data(), s.data() + s.size(), value);
    return (ec == std::errc{} && ptr == s.data() + s.size())
               ? std::make_optional(value)
               : std::nullopt;
}

std::optional<std::vector<int>> parse_vec(std::string_view s) {
    auto pipe = s | views::split(',') | views::transform([](auto&& r) {
                    return std::string_view{
                        std::addressof(*ranges::begin(r)),
                        static_cast<std::size_t>(ranges::distance(r))};
                }) |
                views::transform(trim) | views::transform(to_int);

    std::vector<int> out;
    for (auto&& opt : pipe) {
        if (!opt) return std::nullopt;
        out.push_back(*opt);
    }
    return out.empty() ? std::nullopt : std::make_optional(out);
}

int job_sequencing(std::vector<Job>& jobs) {
    if (jobs.empty()) return 0;

    ranges::sort(jobs, ranges::greater{}, &Job::profit);

    const int n = static_cast<int>(jobs.size());
    const int max_deadline =
        std::min(n, ranges::max(jobs | views::transform(&Job::deadline)));

    DSU dsu(max_deadline);
    int total_profit = 0;

    for (const auto& [profit, deadline] : jobs) {
        int available_slot = dsu.find(std::min(deadline, max_deadline));

        if (available_slot > 0) {
            total_profit += profit;
            dsu.occupy(available_slot);
        }
    }

    return total_profit;
}

int main(int argc, char* argv[]) {
    if (argc != 3) usage();

    auto profits = parse_vec(argv[1]);
    auto deadlines = parse_vec(argv[2]);

    if (!profits || !deadlines || profits->size() != deadlines->size()) usage();

    std::vector<Job> jobs;
    jobs.reserve(profits->size());
    ranges::transform(*profits, *deadlines, std::back_inserter(jobs),
                      [](int p, int d) { return Job{p, d}; });

    std::cout << job_sequencing(jobs) << '\n';
}