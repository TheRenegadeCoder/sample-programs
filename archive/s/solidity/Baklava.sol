// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Baklava {
    function main (string memory) public pure returns (string memory) {
        string memory output = '';
        for (int i = -10; i <= 10; i++) {
            int numSpaces = (i >= 0) ? i : -i;
            output = string.concat(output, strRepeat(numSpaces, ' '));
            output = string.concat(output, strRepeat(21 - 2 * numSpaces, '*'));
            output = string.concat(output, '\n');
        }

        return output;
    }

    function strRepeat(int n, string memory s) private pure returns (string memory) {
        string memory r = '';
        for (int i = 0; i < n; i++) {
            r = string.concat(r, s);
        }

        return r;
    }
}
