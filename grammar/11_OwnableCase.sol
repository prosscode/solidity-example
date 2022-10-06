// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// complete contract case including:
// state variables
// global variables
// function
// function modifier
// error handling
// constructor

contract Ownable{
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function setOwner(address _owner) external {
        require(_owner!=address(0),"invaild address");
        owner = _owner;
    } 

    modifier onlyOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }

    function onlyOwnerCallThisFunc() external onlyOwner{
        // more code
    }

    function anyCallThisFunc() external{
        // more code
    }
}
