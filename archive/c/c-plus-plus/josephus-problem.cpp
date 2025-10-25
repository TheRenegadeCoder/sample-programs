#include <iostream>
#include <stdexcept>
using namespace std;

int josephus(int n, int k) {
    int res = 0;
    for (int i = 1; i <= n; ++i) {
        res = (res + k) % i;
    }
    return res + 1;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: <n> <k>" << endl;
        return 1;
    }

    try {
        int n = stoi(argv[1]);
        int k = stoi(argv[2]);

        if (n <= 0 || k <= 0) {
            cerr << "Invalid input" << endl;
            return 1;
        }

        cout << josephus(n, k) << endl;
        return 0;

    } catch (const invalid_argument&) {
        cerr << "Invalid input" << endl;
        return 1;
    } catch (const out_of_range&) {
        cerr << "Invalid input" << endl;
        return 1;
    }
}
