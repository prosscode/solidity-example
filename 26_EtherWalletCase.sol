// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet{
    address payable public owner;

    constructor(){
        owner = payable(msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        require(msg.sender == owner,"caller is not owner");
        // owner.transfer(_amount);
        // save gas
        payable(msg.sender).transfer(_amount);

        // also use msg.sender.call{}, msg.sender dont need payable()
        // (bool sent,) = msg.sender.call{value:_amount}("");
        // require(sent,"Failed to send Ether");
    }

    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}