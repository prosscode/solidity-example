// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Mapping
// How to declare a mapping simple and nested
// set, get and delete api usage

// array ['alice', 'bob', 'charlie']
// mapping {'alice':true,'bob':true,'charlie':false}
contract Mapping{
    mapping(address=>uint) public balances;
    mapping(address=>mapping(address=>bool)) public isFriend;  

    function example() external returns (uint,uint){
        balances[msg.sender] = 100;
        uint bal = balances[msg.sender];
        uint bal2 = balances[address(1)]; // uint 0

        balances[msg.sender] += 200;

        delete balances[msg.sender]; // delete value, uint 0
        
        // nested mapping
        isFriend[msg.sender][address(this)] = true;
        return (bal,bal2);
    }
}

// mapping operate case
contract IterableMapping{
    mapping(address=>uint) public balances;
    mapping(address=>bool) public inserted;
    address[] public keys;

    function set(address _key, uint _val) external {
        // set
        balances[_key] = _val;
        if(!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() external view returns (uint) {
        return keys.length;
    }

    function getFirstElement() external view returns(uint) {
        return balances[keys[0]];
    }

    function getLastElement() external view returns(uint) {
        return balances[keys[keys.length]];
    }

    function getElementByIndex(uint _i) external view returns(uint) {
        return balances[keys[_i]];
    }

}