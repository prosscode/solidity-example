// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract A {
    // virtual 表示该方法可以被继承重写
    function head() public view virtual returns (string memory){
        return "A";
    }

    function middle() public view virtual returns (string memory){
        return "A";
    }

    function foo() public pure returns (string memory){
        return "A";
    }
}

// B extend A
contract B is A{
    function head() public pure virtual override returns (string memory){
        return "B";
    }

    function middle() public pure override returns (string memory){
        return "B";
    }
}

// C extend B
contract C is B{
    function head() public pure override returns (string memory){
        return "C";
    }

}


/**
Multi Inheritance
Order of inheritance - most base-like to derived
   X
  /|
Y  |
 \ |
    Z
order X,Y,Z
 */

contract X {
    function foo() public pure virtual returns(string memory){
        return "X";
    }
    
    function bar() public pure virtual returns(string memory){
        return "X";
    }

    function x() public pure virtual returns(string memory){
        return "X";
    }
}

contract Y is X{
    function foo() public pure virtual override returns(string memory){
        return "Y";
    }
    
    function bar() public pure virtual override returns(string memory){
        return "Y";
    }

    function y() public pure virtual returns(string memory){
        return "Y";
    }
}

contract Z is X,Y{
    function foo() public pure override(X,Y) returns(string memory){
        return "Z";
    }
    
    function bar() public pure override(Y,X) returns(string memory){
        return "Z";
    }
}
