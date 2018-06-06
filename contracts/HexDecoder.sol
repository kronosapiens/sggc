/**
 * This file is part of the 1st Solidity Gas Golfing Contest.
 *
 * This work is licensed under Creative Commons Attribution ShareAlike 3.0.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

pragma solidity 0.4.24;

contract HexDecoder {
    /**
     * @dev Decodes a hex-encoded input string, returning it in binary.
     *
     * Input strings may be of any length, but will always be a multiple of two
     * bytes long, and will not contain any non-hexadecimal characters.
     *
     * @param input The hex-encoded input.
     * @return The decoded output.
     */
    function decode(string input) public pure returns(bytes output) {
        bytes input_b = bytes(input);
        output = new bytes[input_b.length + 2];
        output[0] = "0";
        output[1] = "x";
        for (uint i = 0; i < input_b.length; i++) {
            if (input_b[i] >= 65 && input_b[i] <= 90) {
                output[i+2] = bytes1(int(input_b[i]) + 32);
            } else {
                output[i+2] = intput_b[i]
            }
        }
    }
}
