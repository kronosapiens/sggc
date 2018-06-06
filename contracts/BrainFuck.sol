/**
 * This file is part of the 1st Solidity Gas Golfing Contest.
 *
 * This work is licensed under Creative Commons Attribution ShareAlike 3.0.
 * https://creativecommons.org/licenses/by-sa/3.0/
 */

pragma solidity 0.4.24;

contract BrainFuck {

    struct Jump {
        uint start;
        uint end;
    }

    /**
     * @dev Executes a BrainFuck program, as described at https://en.wikipedia.org/wiki/Brainfuck.
     *
     * Memory cells, input, and output values are all expected to be 8 bit
     * integers. Incrementing past 255 should overflow to 0, and decrementing
     * below 0 should overflow to 255.
     *
     * Programs and input streams may be of any length. The memory tape starts
     * at cell 0, and will never be moved below 0 or above 1023. No program will
     * output more than 1024 values.
     *
     * @param program The BrainFuck program.
     * @param input The program's input stream.
     * @return The program's output stream. Should be exactly the length of the
     *          number of outputs produced by the program.
     */
    function execute(bytes program, bytes input) public pure returns(bytes) {
        // Reusable counters
        uint i;
        uint j;

        // Find jumps
        Jump[] memory jumps = findJumps(program);

        // Initialize data and input
        uint8[1024] memory data;
        uint reads = 0;

        // Initialize output
        uint8[1024] memory output;
        uint writes = 0;

        // Run program
        uint dp = 0;
        byte instruction;
        for (uint pc = 0; pc < program.length; pc++) {
            instruction = program[pc];
            if (instruction == byte(">")) {
                dp++;

            } else if (instruction == byte("<")) {
                dp--;

            } else if (instruction == byte("+")) {
                data[dp]++;

            } else if (instruction == byte("-")) {
                data[dp]--;

            } else if (instruction == byte(".")) {
                output[writes++] = data[dp];
  
            } else if (instruction == byte(",")) {
                data[dp] = uint8(input[reads++]);
  
            } else if (instruction == byte("[")) {
                if (data[dp] == 0) {
                    for (j = 0; j < jumps.length; j++) {
                        if (jumps[j].start == pc) {
                            pc = jumps[j].end;
                            break;
                        }
                    }
                }
  
            } else if (instruction == byte("]")) {
                for (j = 0; j < jumps.length; j++) {
                    if (jumps[j].end == pc) {
                        pc = jumps[j].start - 1;
                        break;
                    }
                }
  
            } else {
                continue;
            }
        }

        bytes memory shrunk = new bytes(writes);
        for (i = 0; i < writes; i++) {
            shrunk[i] = byte(output[i]);
        }
        return shrunk;
    }

    function findJumps(bytes program) internal pure returns(Jump[]) {
        uint i;
        uint j;
        uint num_jumps = 0;
        for (i = 0; i < program.length; i++) {
            if (program[i] == byte("[")) num_jumps++;
        }

        Jump[] memory jumps = new Jump[](num_jumps);

        uint jump_idx = 0;
        uint jump_depth = 0;
        uint depth_counter = 0;
        for (i = 0; i < program.length; i++) {
            if (program[i] == byte("[")) {
                jump_depth++;
                jumps[jump_idx++] = Jump(i, 0);
            } else if (program[i] == byte("]")) {
                depth_counter = jump_depth--;
                for (j = 0; j < num_jumps; j++) {
                    if (jumps[j].end == 0) {
                        depth_counter--;
                        if (depth_counter == 0) {
                            jumps[j].end = i;
                            break;
                        }
                    }
                }
            }
        }

        return jumps;
    }
}















