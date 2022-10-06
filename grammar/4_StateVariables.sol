// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StateVariables {
    // 状态变量
    // 初始值123,永远记录在链上
    uint256 public myUint = 123; //0 to 123

    bool public b; // false
    address public myAddress; //0x000...

    function foo() external {
        // 局部变量，只在函数调用时产生
        uint256 notStateVariables = 456;
        bool f = false;
        // more code for local state vars
        // not change vars value on chain
        notStateVariables += 456;
        f = true;

        // change to global state vars
        // will change vars value on chain
        myUint = 123456;
        b = true;
        myAddress = address(1);
    }


    // view 可以读取链上变量值，但不能修改
    // pure 不能读取链上变量值，只存在局部变量
    function globalVars() external view returns(address,uint,uint) {
        // 调用地址
        address sender = msg.sender;
        // block时间戳
        uint timestamp = block.timestamp;
        // blcok id
        uint blockNum = block.number;
        return (sender,timestamp,blockNum);
    }
}
