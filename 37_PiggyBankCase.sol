// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
银行案例
1.可以存钱，往账户存钱
2.可以取钱，账户钱取完，账号销毁
 */
contract PiggyBan{

    // 定义事件，记录存取日志
    event Deposit(uint amount);
    event Withdraw(uint amount);

    address public owner = msg.sender;

    receive() external payable{
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner,"not owner");
        emit Withdraw(address(this).balance);
        // selfdestruct
        selfdestruct(payable(msg.sender));
    }
}