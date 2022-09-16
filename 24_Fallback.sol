// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// fallback executed then
// - function does not exist
// - directly send ETH 

/**
fallback() or receive()?
        Ether is sent to contract
                |
        is msg.data empty?
              /    \
            yes    no
            /        \
receive() exist?     fallback()   
          /  \
        yes   no
        /      \
  receive()  fallback()
 */
contract Fallback{
    event Log(string func, address sender, uint val, bytes data);

    fallback() external payable{
        emit Log("fallback",msg.sender,msg.value,msg.data);
    }

    receive() external payable{
        emit Log("receive",msg.sender,msg.value,"");
    }
}