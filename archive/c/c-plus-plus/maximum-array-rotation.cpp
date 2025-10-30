#include <iostream>
#include <vector>
#include <sstream>

using namespace std;
int main(int argc, char *argv[]) {
    // Check if input exists and isn't empty
    if (argc < 2 || string(argv[1]).empty()) {
        cout << "Usage: please provide a list of integers (e.g. \"8, 3, 1, 2\")";
        return 1;
    }
    // Parse input string
    vector<int> arr;
    string input = argv[1];
    stringstream ss(input);
    string token;

    while (getline(ss, token, ',')) {
        arr.push_back(stoi(token));
    }

    int n = arr.size();
    int arr_sum = 0;
    int current_sum = 0;
    // Get sum of array and first rotation sum
    for (int i = 0; i < n; i++) {
        arr_sum += arr[i];
        current_sum+= i * arr[i];
    }
    
    int max_sum = current_sum;
    // check all other possible rotations
    for (int j = 1; j < n; j++) {
        int rotating_value = arr[n-j];
        // next sum = current sum + gains of shifting values one index higher - loss of moving highest index to 0
        current_sum = current_sum + arr_sum - n * rotating_value;

        if (current_sum > max_sum) {
            max_sum = current_sum;
        }
    }
    cout << max_sum << endl;
    return 0;
}