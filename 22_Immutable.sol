// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Immutable{
    // 45718 gas
    // address public owner = msg.sender;

    // 43585 gas
    address public immutable _owner = msg.sender;
    address public immutable owner;

    constructor(){
        owner = msg.sender;
    }

    function foo() external view returns (uint x){
        require(msg.sender == owner);
        x+=1;
    }
}