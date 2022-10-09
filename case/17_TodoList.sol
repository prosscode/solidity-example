// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// TodoList Case
// insert, update, read from array of structs
contract TodoList{
    struct Todo{
        string text;
        bool completed;
    }

    Todo[] public todos;

    function insertTodo(string calldata _text) external {
        todos.push(Todo({text:_text,completed:false}));
    }

    function updateTodoText(string calldata _text, uint _index) external {
        require(_index<todos.length,"_index out of bound");
        // first
        todos[_index].text = _text;
        // second
        Todo storage update = todos[_index];
        update.text = _text;
    }

    function updateTodoCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }

    function getTodo(uint _index) external view returns(string memory, bool){
        // storge 29397
        // memory 29480
        Todo memory todo = todos[_index];
        return (todo.text,todo.completed);
    }
}