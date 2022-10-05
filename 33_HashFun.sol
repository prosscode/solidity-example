// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HashFunction{

    function hash(string memory text, uint num, address addr) external pure returns(bytes32){
        return keccak256(abi.encodePacked(text,num,addr));
    }

    // 不会压缩，加0补全
    function encode(string memory text, uint num) external pure returns(bytes memory){
        return abi.encode(text,num);
    }

    // encodePacked 压缩结果
    function encodePacked(string memory text, uint num) external pure returns(bytes memory){
        return abi.encodePacked(text,num);
    }

    // 避免hash碰撞产生相同的结果
    function collision(string memory text1, uint x, string memory text2) external pure returns(bytes memory){
        return abi.encodePacked(text1,x, text2);
    }

}