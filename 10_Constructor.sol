// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 构造函数，合约部署时执行一次，用于初始赋值
contract TestConstructor{
    address public owner;
    uint public x;

    constructor(uint _n){
        owner = msg.sender;
        x = _n;
    }
}