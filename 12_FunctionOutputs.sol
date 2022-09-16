// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// return multiple outputs
// named outputs
// destructuring assignment
contract FunctionOutputs{

    function returnMany() public pure returns(uint, bool) {
        return (1,true);
    }

    function namedReturns() public pure returns(uint x, bool b) {
        // return (1,true);
        x = 1;
        b = true;
    }    
    
    function destructingAssignment() public pure returns(uint,bool,bool) {
        (uint x, bool b) = returnMany();
        (, bool _b) = namedReturns();
        return (x,b,_b);
    }

}