#include <algorithm>
#include <charconv>
#include <cmath>
#include <iostream>
#include <numeric>
#include <optional>
#include <ranges>
#include <string_view>
#include <vector>

namespace ranges = std::ranges;
namespace views = std::views;

struct Edge {
    int src;
    int dest;
    int weight;
};

[[noreturn]] void usage() {
    std::cerr << "Usage: please provide a comma-separated list of integers\n";
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

struct DSU {
    std::vector<int> parent;
    std::vector<int> rank;

    explicit DSU(int n) : parent(n), rank(n, 0) {
        std::iota(parent.begin(), parent.end(), 0);
    }

    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }

    void unite(int a, int b) {
        a = find(a);
        b = find(b);

        if (a == b) return;

        if (rank[a] < rank[b])
            parent[a] = b;
        else if (rank[a] > rank[b])
            parent[b] = a;
        else {
            parent[b] = a;
            rank[a]++;
        }
    }
};

int kruskal_mst(std::vector<Edge>& edges, int V) {
    ranges::sort(edges, {}, &Edge::weight);

    DSU dsu(V);

    int cost = 0;
    int used = 0;

    for (const auto& e : edges) {
        if (dsu.find(e.src) != dsu.find(e.dest)) {
            dsu.unite(e.src, e.dest);
            cost += e.weight;

            if (++used == V - 1) break;
        }
    }

    return cost;
}

int main(int argc, char* argv[]) {
    if (argc < 2 || std::string_view(argv[1]).empty()) usage();

    auto values = parse_vec(argv[1]);
    if (!values) usage();

    const int n = static_cast<int>(values->size());
    const int V = static_cast<int>(std::sqrt(n));

    if (V * V != n) usage();

    std::vector<Edge> edges;

    for (int i = 0; i < V; ++i) {
        for (int j = i + 1; j < V; ++j) {
            int w = values->at(i * V + j);
            if (w != 0) edges.push_back({i, j, w});
        }
    }

    std::cout << kruskal_mst(edges, V) << '\n';
}