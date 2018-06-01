/**
 * This file is part of the 1st Solidity Gas Golfing Contest.
 *
 * This work is licensed under Creative Commons Attribution ShareAlike 3.0.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

pragma solidity 0.4.24;

contract Unique {
    /**
     * @dev Removes all but the first occurrence of each element from a list of
     *      integers, preserving the order of original elements, and returns the list.
     *
     * The input list may be of any length.
     *
     * @param input The list of integers to uniquify.
     * @return The input list, with any duplicate elements removed.
     */

    struct LinkedList {
        bytes32 next;
        uint number;
    }

    function inList(bytes32 head, uint value) private pure returns(bool) {
        bytes32 current = head;
        while (current != 0) {
            if (current.number == value) {
                return true;
            }
            current = current.next;
        }
        return false;
    }

    function addList(bytes32 head, uint value) private pure {
        bytes32 current = head;
        while (current != 0) {
            current = current.next;
        }

        bytes32 addr = keccak256(value);
        current.next = LinkedList(addr, value);
    }

    function uniquify(uint[] input) public pure returns(uint[] ret) {
        uint curr;
        uint nunique = 0;
        LinkedList[256] memory seen;
        for (uint i = 0; i < input.length; i++) {
            curr = input[i];
            if (!inList(seen[curr % 256], curr)) {
                addList(seen[curr % 256], curr);
                nunique++;
            }
        }

        ret = new uint[](nunique);
        uint nwritten = 0;
        LinkedList[256] memory written;
        for (uint j= 0; j < input.length; j++) {
            curr = input[j];
            if (!inList(written[curr % 256], curr)) {
                addList(written[curr % 256], curr);
                ret[nwritten++] = curr;
            }
        }
    }

}
