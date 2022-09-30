// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
A calls B, sends 100 wei
        B calls C, sends 50 wei
A --> B --> C
        msg.sender = B
        msg.value = 50
        execute code on C's state variables
        use ETH in C

A calls B, sends 100 wei
        B delegate C
A --> B --> C
        msg.sender = A
        msg.value = 100
        execute code on B's state variables
        use ETH in B
*/

contract TestDelegateCall{
    uint public num;
    address public sender;
    uint public value;
    // only here after 3 variables
    address public owner;


    function setVars(uint _num) external payable{
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}


contract DelegateCall{
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _addr, uint _num) external payable{
        // signature call
        // (bool success, bytes memory data) = _addr.delegatecall(
        //     abi.encodeWithSignature("setVars(uint)", _num)
        // );

        // selector call
        (bool success, bytes memory data) = _addr.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );
        require(success,"delegate call failed");
    }
}