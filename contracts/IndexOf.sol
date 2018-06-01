/**
 * This file is part of the 1st Solidity Gas Golfing Contest.
 *
 * This work is licensed under Creative Commons Attribution ShareAlike 3.0.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

pragma solidity 0.4.24;

contract IndexOf {
    /**
     * @dev Returns the index of the first occurrence of `needle` in `haystack`,
     *      or -1 if `needle` is not found in `haystack`.
     *
     * Input strings may be of any length <2^255.
     *
     * @param haystack The string to search.
     * @param needle The string to search for.
     * @return The index of `needle` in `haystack`, or -1 if not found.
     */
    function indexOf(string haystack, string needle) public pure returns(int) {
        bytes memory haystack_b = bytes(haystack);
        bytes memory needle_b = bytes(needle);

        if (needle_b.length == 0) {
            return 0;
        }

        if (haystack_b.length < needle_b.length) {
            return -1;
        }

        uint i;
        uint j;
        int index = -1;
        for (i = 0; i <= (haystack_b.length - needle_b.length); i++) {
            for (j = 0; j < needle_b.length; j++) {
                if (needle_b[j] != haystack_b[i + j]) {
                    break;
                }
            }
            if (j == needle_b.length) {
                index = int(i);
                break;
            }
        }

        return index;
    }
}
