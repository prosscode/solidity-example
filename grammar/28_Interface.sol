// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Counter{
    uint public count;

    function inc() external{
        count+=1;
    }

    function dec() external{
        count -=1;
    }
}


// define interface 
interface ICounter{
    function count() external view returns (uint);
    function inc() external;
}


contract CallInterface{
    uint public count;
    function example(address _counter) external{
        // Counter(_counter).inc();
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}