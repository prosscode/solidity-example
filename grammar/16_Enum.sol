// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Enum{

    enum Status{
        NONE, // default enum value of index 0
        Pending,
        Shipped,
        Completed,
        Rejected,
        Canceled
    }

    Status public status;

    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    // return enum Status indexs
    function get() external view returns (Status) {
        return status;
    }

    function set(Status _status) external {
        status = _status;
    }

    function ship() external{
        status = Status.Shipped;
    }

    function reset() external{
        delete status; // recover to defualt enum value
    }
}