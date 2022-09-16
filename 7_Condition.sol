// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Condition {
    function IfElseExample(uint256 x) external pure returns (uint256) {
        if (x < 10) {
            return 1;
        } else if (x < 20) {
            return 2;
        } else {
            return 3;
        }
    }

    function ternary(uint256 x) external pure returns (uint256) {
        // if (x < 10) {
        //     return 1;
        // }
        // return 2;

        // 三元表达
        return x < 10 ? 1 : 2;
    }

    function forLoops() external pure {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            // more code
            if (i == 6) {
                break;
            }

            uint256 j;
            while (j < 10) {
                j++;
            }
        }
    }

    // n越大，循环越多，gas费消耗也越多
    function sum(uint n) external pure returns(uint){
        uint s;
        for(uint i=0;i<n;i++){
            s+=i;
        }
        return s;
    }
}
