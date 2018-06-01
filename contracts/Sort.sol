/**
 * This file is part of the 1st Solidity Gas Golfing Contest.
 *
 * This work is licensed under Creative Commons Attribution ShareAlike 3.0.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

pragma solidity 0.4.24;

contract Sort {
    /**
     * @dev Sorts a list of integers in ascending order.
     *
     * The input list may be of any length.
     *
     * @param input The list of integers to sort.
     * @return The sorted list.
     */
    function sort(uint[] input) public pure returns(uint[]) {
        quickSort(input, 0, input.length);
        return input;
    }

    function quickSort(uint[] input, uint lo, uint hi) private pure {
        if (hi > lo) {
            uint p = partition(input, lo, hi);
            quickSort(input, lo, p);
            quickSort(input, p+1, hi);
        }
    }

    // NOTE: input[hi] will return an out-of-bounds error.
    function partition(uint[] input, uint lo, uint hi) private pure returns(uint) {
        uint pivot = input[hi-1];
        uint i = lo;
        for (uint j = lo; j < hi-1; j++) {
            if (input[j] <= pivot) {
                swap(input, i, j);
                i++;
            }
        }
        swap(input, i, hi-1);
        return i;
    }

    function swap(uint[] input, uint i, uint j) private pure {
        uint temp = input[i];
        input[i] = input[j];
        input[j] = temp;
    }

    // function choosePivot(uint[] input, uint lo, uint hi) private pure returns(uint) { 
    //     uint a = input[lo];
    //     uint b = input[lo + ((hi - lo) / 2)];
    //     uint c = input[hi];

    //     return max(min(a,b), min(max(a,b),c)); // median
    // }

    // function max(uint a, uint b) private pure returns(uint) {
    //     return a > b ? a : b;
    // }

    // function min(uint a, uint b) private pure returns(uint) {
    //     return a < b ? a : b;
    // }

}
