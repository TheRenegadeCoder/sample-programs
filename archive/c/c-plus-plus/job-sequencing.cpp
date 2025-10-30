#include <iostream>
#include <vector>
#include <string>
#include <sstream>
#include <algorithm>

using namespace std;

const string usage_msg = "Usage: please provide a list of profits and a list of deadlines\n";
const int MAX_JOBS = 100;

struct Job {
    int profit;
    int deadline;
};

bool compare(const Job &a, const Job &b) {
    return a.profit > b.profit;
}

int jobSequencing(vector<Job> &jobs) {
    sort(jobs.begin(), jobs.end(), compare);

    int maxDeadline = 0;
    for (auto &job : jobs) {
        maxDeadline = max(maxDeadline, job.deadline);
    }

    vector<int> slot(MAX_JOBS, 0);
    int totalProfit = 0;

    for (auto &job : jobs) {
        for (int j = min((int)jobs.size(), job.deadline) - 1; j >= 0; --j) {
            if (slot[j] == 0) {
                slot[j] = 1;
                totalProfit += job.profit;
                break;
            }
        }
    }

    return totalProfit;
}

vector<int> parseInput(const string &input) {
    vector<int> arr;
    stringstream ss(input);
    string token;
    while (getline(ss, token, ',')) {
        token.erase(0, token.find_first_not_of(" \t"));
        token.erase(token.find_last_not_of(" \t") + 1);
        if (!token.empty()) {
            try {
                arr.push_back(stoi(token));
            } catch (...) {
                throw invalid_argument("Invalid input");
            }
        }
    }
    return arr;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cout << usage_msg;
        return 1;
    }

    vector<int> profits, deadlines;
    try {
        profits = parseInput(argv[1]);
        deadlines = parseInput(argv[2]);
    } catch (...) {
        cout << usage_msg;
        return 1;
    }

    if (profits.size() != deadlines.size() || profits.empty()) {
        cout << usage_msg;
        return 1;
    }

    vector<Job> jobs;
    for (size_t i = 0; i < profits.size(); ++i) {
        jobs.push_back({profits[i], deadlines[i]});
    }

    int result = jobSequencing(jobs);
    cout << result << endl;

    return 0;
}
