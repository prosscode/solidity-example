// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Structs{

    struct Car{
        string model;
        uint year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address=>Car[]) public carsByOwner;

    function exampleStruct() external{
        Car memory toyota = Car("toyota",1990,msg.sender);
        Car memory lambo = Car({model:"lamborghini",owner:msg.sender,year:1980});
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari",2020,msg.sender));
        
        // 存储位置
        // storage, 状态变量，可以修改链上状态数据
        // memory, 局部变量，可以获取数据，但不能修改，修改只在函数运行时有效
        // calldata, 可以修饰string变量，可以在函数之间传递参数，减少gas费
        Car storage _car = cars[0];
        _car.year = 1999;
        // recover the default value of data type
        delete _car.owner;
        delete cars[1];
    }
}