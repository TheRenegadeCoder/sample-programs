#include <algorithm>
#include <iostream>
#include <sstream>
#include <string>
#include <vector>

struct Point
{
    int x{};
    int y{};

    Point() = default;
    Point(int x_, int y_) : x(x_), y(y_)
    {
    }

    bool operator<(const Point &other) const
    {
        if (x != other.x)
            return x < other.x;
        return y < other.y;
    }
};

[[noreturn]] void usage()
{
    std::cerr
        << R"(Usage: please provide at least 3 x and y coordinates as separate lists (e.g. "100, 440, 210"))"
        << '\n';
    std::exit(1);
}

std::vector<int> parseList(const std::string &input)
{
    std::vector<int> out;
    std::stringstream ss(input);

    for (std::string token; std::getline(ss, token, ',');)
    {
        auto start = token.find_first_not_of(" \t");
        if (start == std::string::npos)
            usage();

        const auto end = token.find_last_not_of(" \t");
        token = token.substr(start, end - start + 1);

        size_t pos = 0;
        int value = 0;

        try
        {
            size_t pos = 0;
            const int value = std::stoi(token, &pos);

            if (pos != token.size())
                usage();

            out.push_back(value);
        }
        catch (...)
        {
            usage();
        }
    }

    return out;
}

std::vector<Point> parseCoordinates(const std::string &xs,
                                    const std::string &ys)
{
    auto x = parseList(xs);
    auto y = parseList(ys);

    if (x.size() != y.size() || x.size() < 3)
        usage();

    std::vector<Point> pts;
    pts.reserve(x.size());

    std::transform(x.begin(), x.end(), y.begin(), std::back_inserter(pts),
                   [](int a, int b) { return Point{a, b}; });

    return pts;
}

long long cross(const Point &a, const Point &b, const Point &c)
{
    return 1LL * (b.x - a.x) * (c.y - a.y) - 1LL * (b.y - a.y) * (c.x - a.x);
}

std::vector<Point> convexHull(std::vector<Point> pts)
{
    if (pts.size() < 3)
        usage();

    std::sort(pts.begin(), pts.end());

    std::vector<Point> lower, upper;
    lower.reserve(pts.size());
    upper.reserve(pts.size());

    auto build_half = [&](auto begin, auto end, auto &hull) {
        for (auto it = begin; it != end; ++it)
        {
            const auto &p = *it;

            while (hull.size() >= 2
                   && cross(hull[hull.size() - 2], hull.back(), p) <= 0)
            {
                hull.pop_back();
            }

            hull.push_back(p);
        }
    };

    build_half(pts.begin(), pts.end(), lower);
    build_half(pts.rbegin(), pts.rend(), upper);

    lower.pop_back();
    upper.pop_back();

    lower.insert(lower.end(), std::make_move_iterator(upper.begin()),
                 std::make_move_iterator(upper.end()));

    return lower;
}

int main(int argc, char *argv[])
{
    if (argc != 3)
        usage();

    const auto hull = convexHull(parseCoordinates(argv[1], argv[2]));

    for (const auto &[x, y] : hull)
        std::cout << '(' << x << ", " << y << ")\n";
}