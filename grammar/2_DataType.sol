// SPDX-License-Identifier: MIT
// Data type, values and reference
pragma solidity ^0.8.0;

contract DataType {
    bool public b = true;

    // unit = unit256   0 to 2^256-1
    // unit8    0 to 2^8-1
    // unit15   0 to 2^16-1
    uint256 public u = 123;

    // int = int256   -2^255 to 2^255-1
    // int128   -2^127 to 2^127-1
    int256 public i = -123;
    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;

    // address
    address public addr = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8;
    // bytes
    bytes32 public b32 =
        0xd8b934580fcE35a11B58C6D73aDeE468a2833fa812dff3e7c508b629295926fa;
}
