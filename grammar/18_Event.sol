// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Event{
    // event存储更节约gas
    event Log(string message, uint val);
    // 变量类型之后加上indexed索引，表示可以在链外搜索查询，web3 ether等外部sdk可以调用
    // up to 3 indexed of a event
    event IndexedLog(address indexed sender,uint val);
    
    // 也是写入方法，不能标记为pure或view，改变了链上的事件状态
    function example() external {
        emit Log("message",123);
        emit IndexedLog(msg.sender,456);
    }

    event Message(address indexed _from, address indexed _to, string message);

    function sendMessage(address _from, address _to, string calldata _message) external {
        emit Message(_from, _to, _message);
    }

}
