// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// payable修饰，表示能接受主币的变量和函数
contract Payable{
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
    }

    function deposit() external payable {

    }   

    function getBalance() external view returns (uint){
        return address(this).balance;
    }
}
