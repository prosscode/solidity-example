// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 2 ways to call parent contructors
// order of inheritance
contract A{
    string public name;

    constructor(string memory _name){
        name = _name;
    }
}

contract B{
    string public text;

    constructor(string memory _text){
        text = _text;
    }
}

// first way
contract C is A("a"),B("b"){

}

// second way
contract D is A,B{
    constructor(string memory _name,string memory _text) B(_text) A(_name){}
}

// second way
contract E is A("a"),B{
    string public _flag;
    constructor(string memory _name,string memory _text) B(_text){
        _flag = _name;
    }
}


/**
calling parent function
- direct
- super
   F
  / \
 G   H
  \ /
   I
 */

contract F{
    event Log(string message);

    function foo() public virtual{
        emit Log("F.foo");
    }

    function bar() public virtual{
        emit Log("F.bar");
    }
}

contract G is F{

    function foo() public virtual override{
        emit Log("G.foo");
        // direct call
        F.foo();
    }

    function bar() public virtual override{
        emit Log("G.bar");
        // super call
        super.bar();
    }
}

contract H is F{

    function foo() public virtual override{
        emit Log("H.foo");
        // direct call
        F.foo();
    }

    function bar() public virtual override{
        emit Log("H.bar");
        // super call
        super.bar();
    }
}

contract I is H,G{

    function foo() public override(H,G){
        // direct call
        F.foo();
    }

    function bar() public override(H,G){
        // super call
        super.bar();
    }
}