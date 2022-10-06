// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Array - dynamic or fixed size 
// Initialization
// Insert(push), get, update, delete, pop, length api usgae
// Create array in memory
// returning array from function
contract TestArray{
    uint[] public nums;
    uint[3] public numsFixed = [1,2,3];
    
    function example() external returns (uint,uint){
        nums = [1,2,3,4];
        nums.push(5); // [1,2,3,4,5]
        uint x = nums[1]; // x = 2
        nums[2] = 6; // [1,2,6,4,5]
        // delete not change array size, set default value 0
        delete nums[2]; // [1,2,0,4,5]
        nums.pop(); // [1,2,0,4]
        uint len = nums.length; // len = 4

        // create array in memory, must be a fixed size
        uint[] memory mnums = new uint[](5);
        // only set value by index
        mnums[1] = 10;
        return (x,len);
    }

    // return array
    function returnArray() external view returns (uint[] memory) {
        return nums;
    }

    function returnFixedArray() external view returns (uint[3] memory) {
        return numsFixed;
    }

    modifier checkIndex(uint _index){
        require(_index < nums.length, "_index out of bound");
        _;
    }

    // wheel for delete array element and change array size
    // [1,2,3,4] -> delete[2] -> [1,2,4]
    // in_progress: [1,2,3,4] -> [1,2,3,4,4] -> pop() -> [1,2,3]
    // [1] -> delete[0] -> []
    function removeArrayElementMove(uint _index) public checkIndex(_index) {
        // check position
        // require(_index < nums.length, "_index out of bound");

        for(uint i = _index; i<nums.length-1; i++){
            nums[i] = nums[i+1];
        }
        nums.pop();
    }

    function removeArrayElementReplace(uint _index) public checkIndex(_index) {
        nums[_index] = nums[nums.length - 1];
        nums.pop();
    }

    function testRemove() external {
        nums = [1,2,3,4,5,6];
        removeArrayElementMove(3);  // [1,2,3,5,6]
        assert(nums.length == 5);

        removeArrayElementReplace(1); // [1,3,5,6]
        assert(nums[nums.length - 1] == 6);
        assert(nums.length == 4); 
    }
}