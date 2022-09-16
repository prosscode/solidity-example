// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Function modifier - reuse code before and / or after function
// Basic, inputs, sandwich

contract FunctionModifier {
    bool public paused;
    uint256 public count;

    function setPause(bool _paused) external {
        paused = _paused;
    }

    function inc() external WhenNotPaused {
        // require(!paused, "paused");
        count += 1;
    }

    function dec() external WhenNotPaused {
        // require(!paused, "paused");
        count -= 1;
    }

    // reuse Basic
    modifier WhenNotPaused() {
        require(!paused, "paused");
        // 运行到_;后跳回函数中继续执行
        _;
    }

    // reuse inputs
    modifier cap(uint x) {
        require(x < 100, "x>100");
        _;
    }

    function incBy(uint256 x) external WhenNotPaused cap(x) {
        // require(x < 100, "x>100");
        // require(!paused, "paused");
        count += x;
    }


    modifier sandwich(){
        // code here
        count +=10 ;
        _;
        // more code here
        count *= 2;
    }

    function foo() external sandwich{
        count+=1;
    }
}
