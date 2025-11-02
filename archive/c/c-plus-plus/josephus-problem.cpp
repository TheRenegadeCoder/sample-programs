#include <iostream>
#include <string>
#include <stdexcept>
using namespace std;

int josephus(int n, int k) {
    if (n == 1)
        return 1;
    else
        return (josephus(n - 1, k) + k - 1) % n + 1;
}

int main(int argc, char* argv[]) {
    const string usage_msg = "Usage: please input the total number of people and number of people to skip.\n";

    if (argc != 3) {
        cerr << usage_msg;
        return 1;
    }

    try {
        int n = stoi(argv[1]);
        int k = stoi(argv[2]);

        if (n <= 0 || k <= 0) {
            cerr << usage_msg;
            return 1;
        }

        int result = josephus(n, k);
        cout << result << endl;
        return 0;

    } catch (...) {
        cerr << usage_msg;
        return 1;
    }
}
