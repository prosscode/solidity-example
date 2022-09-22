// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 回退函数
// fallback executed then
// 2 cases
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
  receive() exist?  fallback()   
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

    // receive ETH
    receive() external payable{
        emit Log("receive",msg.sender,msg.value,"");
    }
}