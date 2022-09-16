// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// visibility, state variables and functions
//  - private, only inside contract
//  - internal, only inside contract and child contracts
//  - public, inside and outside contract
//  - external, only outside contract

contract Visibility{
    uint public x;
    string private y;
    bool internal z;

    function foo() external pure returns(string memory){
        return "external visibility";
    }
}