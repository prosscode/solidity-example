// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library Math{
    function max(uint x,uint y) internal pure returns(uint){
        return x > y ? x:y;
    }

    function findElementIndex(uint[] storage arr, uint x) internal view returns(uint){
        for(uint i=0;i<arr.length;i++){
            if(arr[i] == x){
                return i;
            }
        }
        revert("not found element");
    }
}

contract TestLibrary{
    
    uint[] arr = [1,2,3,4,5];

    function max(uint x, uint y) external pure returns(uint){
        return Math.max(x, y);
    }

    // use library  binds type
    using Math for uint[];

    function testFind() external view returns(uint){
        // return Math.findElementIndex(arr, 3);
        return arr.findElementIndex(3);
    }
}