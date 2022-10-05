// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// selfdestruct
//  - delete contract
//  - force send Ether to any address

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    // after kill and this method not return 
    function testCall() external pure returns(uint){
        return 123;
    }
}


contract Helper{

    constructor() payable{}

    function getBalance() external view returns (uint){
        return address(this).balance;
    }

    function invokeKill(Kill _kill) external{
        _kill.kill();
    }
}