// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 3 ways to send ETH
// transfer - 2300 gas, reverts
// send - 2300 gas, returns bool
// call - all gas, returns bool and data
contract SendEther{
    // 接受主币
    constructor() payable {}
    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable{
        _to.transfer(123);
    }

    function sendViaSend(address payable _to) external payable{
        bool sent = _to.send(123);
        require(sent,"send failed");
    }

    function sendViaCall(address payable _to) external payable{
        (bool success,) = _to.call{value:123}("");
        require(success,"call failed");
    }
}

contract ReceiverETH{
    event Log(uint amount,uint gas);

    receive() external payable{
        emit Log(msg.value,gasleft());
    }
}