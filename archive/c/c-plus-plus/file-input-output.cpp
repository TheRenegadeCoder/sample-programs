#include <cstdlib>
#include <filesystem>
#include <format>
#include <fstream>
#include <iostream>
#include <string>

namespace fs = std::filesystem;

bool write_file(const fs::path& path, std::string_view content) {
    std::ofstream out(path, std::ios::binary | std::ios::trunc);

    if (!out) {
        std::cerr << "Error: Could not open '" << path << "' for writing!\n";
        return false;
    }

    out.write(content.data(), static_cast<std::streamsize>(content.size()));
    return static_cast<bool>(out);
}

bool read_file(const fs::path& path) {
    std::ifstream in(path, std::ios::binary);

    if (!in) {
        std::cerr << "Error: Could not open '" << path << "' for reading!\n";
        return false;
    }

    std::cout << in.rdbuf();
    return true;
}

int main() {
    const fs::path target = "output.txt";

    constexpr std::string_view data =
        "A line of text\n"
        "Another line of text\n";

    if (!write_file(target, data)) return 1;
    if (!read_file(target)) return 1;
}