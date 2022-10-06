// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FunctionIntro {
    uint256 public num;

    // external 外部函数，只能在外部读取
    // pure函数修饰，不能读和写状态变量，也就是不对链上有读和写操作，只能拥有局部变量
    // view函数修饰，只能读到状态变量
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        return x - y;
    }

    // view函数修饰，可以读取状态变量，可以对链上变量进行读操作
    function getVariable() external view returns (uint256) {
        return num;
    }


    // 什么都不加修饰，表示可修改状态变量
    function writeVariable() external returns (uint256) {
        return num += 1;
    }
}
