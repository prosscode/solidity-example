// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TestCall{
    string public message;
    uint public x;
    event Log(string message);
    
    fallback() external payable{
        emit Log("fallback was called");
    }

    function foo(string memory _message,uint _x) external payable returns(bool,uint){
        message = _message;
        x = _x;
        return(true,999);
    }
}

contract AbiSignatureCall{
    bytes public data;

    function callFoo(address _address) external payable{
        (bool success, bytes memory _data) = _address.call(
            abi.encodeWithSignature("foo(string uint)", "call foo", 123)
        );
        // bring value and gas to call
        // (bool success, bytes memory _data) = _address.call{value: 111,gas: 5000}(
            // abi.encodeWithSignature("foo(string uint)", "call foo", 123)
        // );
        require(success,"call failed");
        data = _data;
    }
    
    function callNotExistMethod(address _address) external {
        (bool success, ) = _address.call(
            abi.encodeWithSignature("notExistMethod()")
        );
        require(success,"call failed");
    }
}