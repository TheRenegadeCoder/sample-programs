#include <iostream>
#include <stdexcept>
#include <vector>
using namespace std;

void josephus(int n, int k) {
    vector<int> people;
    for (int i = 1; i <= n; ++i) {
        people.push_back(i);
    }

    int index = 0;
    while (people.size() > 1) {
        cout << "[" << people[0];
        for (size_t i = 1; i < people.size(); ++i) {
            cout << ", " << people[i];
        }
        cout << "] " << (k - 1) << " " << index << endl;
        index = (index + k - 1) % people.size();
        people.erase(people.begin() + index);
        if (index == people.size()) index = 0;
    }
    cout << people[0] << endl;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: please input the total number of people and number of people to skip.\n";
        return 1;
    }
    try {
        int n = stoi(argv[1]);
        int k = stoi(argv[2]);
        if (n <= 0 || k <= 0) {
            cerr << "Usage: please input the total number of people and number of people to skip.\n";
            return 1;
        }
        josephus(n, k);
        return 0;
    } catch (const invalid_argument&) {
        cerr << "Usage: please input the total number of people and number of people to skip.\n";
        return 1;
    } catch (const out_of_range&) {
        cerr << "Usage: please input the total number of people and number of people to skip.\n";
        return 1;
    }
}