// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// require, revert, assert
// state update are revert - gas refund
// custom error - save gas

contract Error {
    // require(condition,"error info")
    function testRequire(uint256 x) public pure {
        require(x <= 10, "x>10");
        // more code
    }

    // revert("error info")
    function testRevert(uint256 y) public pure {
        if (y <= 10) {
            revert("y>10");
        }
    }

    uint256 public num = 123;

    // assert(condition)
    function testAssert() public view {
        assert(num == 123);
    }

    function addNum() public {
        num++;
    }

    // refund gas op
    function refundGas(uint256 m) public {
        num += 1;
        require(m < 10);
    }

    // custom error and save gas
    error MyError(address caller, uint256 n);

    function testCustomError(uint256 n) public view {
        if (n > 10) {
            revert MyError(msg.sender, n);
        }
    }
    
}
