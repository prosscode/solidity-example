// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// gas费有区别
contract Constants{
    // 21442 gas (Cost only applies when called by a contract)
    address public constant MY_ADDRESS_CONSTANTS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint public constant MY_UINT = 123;

}

contract Var{
    // 23553 gas 
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

}