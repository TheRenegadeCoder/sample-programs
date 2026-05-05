#include <charconv>
#include <format>
#include <functional>
#include <iostream>
#include <numeric>
#include <optional>
#include <string_view>
#include <unordered_map>

class Fraction {
private:
    long long num;
    long long den;

    Fraction(long long n, long long d) : num(n), den(d) { normalize(); }

    void normalize() {
        if (den < 0) {
            num = -num;
            den = -den;
        }
        long long g = std::gcd(num, den);
        num /= g;
        den /= g;
    }

public:
    static std::optional<Fraction> from_string(std::string_view s) {
        auto parse = [](std::string_view part) {
            long long val{};
            auto [ptr, ec] =
                std::from_chars(part.data(), part.data() + part.size(), val);

            return (ec == std::errc{} && ptr == part.data() + part.size())
                       ? std::make_optional(val)
                       : std::nullopt;
        };

        auto pos = s.find('/');
        auto num = parse(s.substr(0, pos));
        auto den =
            (pos == std::string_view::npos) ? 1 : parse(s.substr(pos + 1));

        if (!num || !den || *den == 0) return std::nullopt;
        return Fraction(*num, *den);
    }

    Fraction& operator+=(const Fraction& r) {
        num = num * r.den + r.num * den;
        den *= r.den;
        normalize();
        return *this;
    }
    Fraction& operator-=(const Fraction& r) {
        num = num * r.den - r.num * den;
        den *= r.den;
        normalize();
        return *this;
    }
    Fraction& operator*=(const Fraction& r) {
        num *= r.num;
        den *= r.den;
        normalize();
        return *this;
    }
    Fraction& operator/=(const Fraction& r) {
        if (r.num != 0) {
            num *= r.den;
            den *= r.num;
            normalize();
        }
        return *this;
    }

    friend Fraction operator+(Fraction l, const Fraction& r) { return l += r; }
    friend Fraction operator-(Fraction l, const Fraction& r) { return l -= r; }
    friend Fraction operator*(Fraction l, const Fraction& r) { return l *= r; }
    friend Fraction operator/(Fraction l, const Fraction& r) { return l /= r; }

    auto operator<=>(const Fraction& r) const {
        return num * r.den <=> r.num * den;
    }
    bool operator==(const Fraction&) const = default;

    long long n() const { return num; }
    long long d() const { return den; }
};

template <>
struct std::formatter<Fraction> {
    constexpr auto parse(format_parse_context& ctx) { return ctx.begin(); }
    auto format(const Fraction& f, format_context& ctx) const {
        return std::format_to(ctx.out(), "{}/{}", f.n(), f.d());
    }
};

int main(int argc, char* argv[]) {
    if (argc != 4) {
        std::cerr << "Usage: ./fraction-math operand1 operator operand2\n";
        return EXIT_FAILURE;
    }

    auto a = Fraction::from_string(argv[1]);
    auto b = Fraction::from_string(argv[3]);

    if (!a || !b) {
        std::cerr << "Error: invalid fraction input\n";
        return EXIT_FAILURE;
    }

    std::string_view op = argv[2];

    using Op = std::function<void()>;

    const std::unordered_map<std::string_view, Op> ops = {
        {"+", [&] { std::cout << std::format("{}\n", *a + *b); }},
        {"-", [&] { std::cout << std::format("{}\n", *a - *b); }},
        {"*", [&] { std::cout << std::format("{}\n", *a * *b); }},
        {"/", [&] { std::cout << std::format("{}\n", *a / *b); }},

        {"==", [&] { std::cout << (*a == *b) << '\n'; }},
        {"!=", [&] { std::cout << (*a != *b) << '\n'; }},
        {"<", [&] { std::cout << (*a < *b) << '\n'; }},
        {">", [&] { std::cout << (*a > *b) << '\n'; }},
        {"<=", [&] { std::cout << (*a <= *b) << '\n'; }},
        {">=", [&] { std::cout << (*a >= *b) << '\n'; }},
    };

    if (auto it = ops.find(op); it != ops.end()) {
        it->second();
    } else {
        std::cerr << "Error: invalid operator\n";
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}