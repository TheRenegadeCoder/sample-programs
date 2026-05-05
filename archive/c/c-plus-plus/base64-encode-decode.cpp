#include <algorithm>
#include <array>
#include <cstdint>
#include <iostream>
#include <string>
#include <string_view>
#include <vector>

enum class Mode { encode, decode };

namespace base64 {

constexpr std::string_view alphabet =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "abcdefghijklmnopqrstuvwxyz"
    "0123456789+/";

constexpr auto make_table() {
    std::array<std::int8_t, 256> t{};
    t.fill(-1);

    for (std::size_t i = 0; i < alphabet.size(); ++i)
        t[static_cast<unsigned char>(alphabet[i])] =
            static_cast<std::int8_t>(i);

    return t;
}

constexpr auto table = make_table();

constexpr bool is_b64(unsigned char c) { return table[c] != -1; }
constexpr bool is_pad(char c) { return c == '='; }

bool valid(std::string_view s) {
    using std::all_of;

    if (s.empty() || s.size() % 4 != 0) return false;

    const auto first_pad = s.find('=');

    if (first_pad == std::string_view::npos) {
        return all_of(s.begin(), s.end(), is_b64);
    }

    // padding must be in last 2 chars only
    if (s.size() - first_pad > 2) return false;

    return all_of(s.begin(), s.begin() + first_pad, is_b64) &&
           all_of(s.begin() + first_pad, s.end(), is_pad);
}

}  // namespace base64

std::string encode(std::string_view input) {
    std::string out;
    out.reserve(((input.size() + 2) / 3) * 4);

    std::uint32_t buffer = 0;
    int bits = 0;

    for (unsigned char c : input) {
        buffer = (buffer << 8) | c;
        bits += 8;

        while (bits >= 6) {
            bits -= 6;
            out.push_back(base64::alphabet[(buffer >> bits) & 0x3F]);
        }
    }

    if (bits > 0) {
        out.push_back(base64::alphabet[(buffer << (6 - bits)) & 0x3F]);
    }

    while (out.size() % 4 != 0) out.push_back('=');

    return out;
}

struct DecodeResult {
    bool ok{};
    std::string value;
    std::string_view error;
};

DecodeResult decode(std::string_view input) {
    if (!base64::valid(input)) return {false, {}, "invalid base64"};

    std::string out;
    out.reserve((input.size() / 4) * 3);

    std::uint32_t buffer = 0;
    int bits = 0;

    for (unsigned char c : input) {
        if (c == '=') break;

        int v = base64::table[c];
        if (v < 0) return {false, {}, "invalid character"};

        buffer = (buffer << 6) | static_cast<std::uint32_t>(v);
        bits += 6;

        while (bits >= 8) {
            bits -= 8;
            out.push_back(static_cast<char>((buffer >> bits) & 0xFF));
        }
    }

    return {true, std::move(out), {}};
}

void usage() {
    std::cerr << "Usage: please provide a mode and a string to encode/decode\n";
    std::exit(1);
}

int main(int argc, char** argv) {
    if (argc != 3) usage();

    std::string_view mode = argv[1];
    std::string_view text = argv[2];

    if (text.empty()) usage();

    if (mode == "encode") {
        std::cout << encode(text) << '\n';
    } else if (mode == "decode") {
        auto res = decode(text);
        if (!res.ok) usage();
        std::cout << res.value << '\n';
    } else {
        usage();
    }
}