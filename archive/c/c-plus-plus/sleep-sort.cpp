#include <iostream>
#include <vector>
#include <string>
#include <thread>
#include <mutex>
#include <sstream>
#include <chrono>

std::mutex mtx;
std::vector<int> sorted_numbers;

void sortNumber(int number) {
    std::this_thread::sleep_for(std::chrono::seconds(number));
    std::lock_guard<std::mutex> lock(mtx);
    sorted_numbers.push_back(number);
}

std::vector<int> parseInput(const std::string &input) {
    std::vector<int> numbers;
    std::stringstream ss(input);
    std::string token;

    while (std::getline(ss, token, ',')) {
        try {
            int num = std::stoi(token);
            numbers.push_back(num);
        } catch (...) {
            throw std::invalid_argument("Invalid input");
        }
    }

    return numbers;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n";
        return 1;
    }

    std::string input = argv[1];
    if (input.empty() || input[0] == ' ') {
        std::cerr << "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n";
        return 1;
    }

    std::vector<int> numbers;
    try {
        numbers = parseInput(input);
    } catch (...) {
        std::cerr << "Usage: please provide a valid list of integers in the format \"1, 2, 3, 4, 5\"\n";
        return 1;
    }

    if (numbers.size() < 2) {
        std::cerr << "Usage: please provide a list of at least two integers to sort in the format \"1, 2, 3, 4, 5\"\n";
        return 1;
    }

    std::vector<std::thread> threads;
    for (int num : numbers) {
        threads.emplace_back(sortNumber, num);
    }

    for (auto &t : threads) {
        t.join();
    }

    for (size_t i = 0; i < sorted_numbers.size(); ++i) {
        std::cout << sorted_numbers[i];
        if (i < sorted_numbers.size() - 1) std::cout << ", ";
    }
    std::cout << std::endl;

    return 0;
}
