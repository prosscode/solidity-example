// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
多签钱包，必须在钱包中有多个人同意的情况下，才能把主币转出
 */
contract MultiSignatureWallet{
    // define event, txId = transactions.i - 1
    event Deposit(address indexed sender, uint amount);
    event Submit(uint indexed txId);
    event Approve(address indexed approved, uint indexed txId);
    event Revoke(address indexed Revoker, uint indexed txId);
    event Execute(uint indexed txId);

    // transaction struct 
    struct Transaction{
        address to;
        uint value;
        bytes data;
        bool executed;
    }

    // multiSigature owners
    address[] public owners;
    mapping(address => bool) public isOwner;
    uint public required;
    // transactions 
    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approved;

    modifier onlyOwner(){
        require(isOwner[msg.sender],"not owner");
        _;
    }

    // txId 是否存在
    modifier txExists(uint _txId) {
        require(_txId < transactions.length, "tx does not exist");
        _;
    }

    // txId是否已经审批
    modifier notApproved(uint _txId){
        require(!approved[_txId][msg.sender], "tx already approved");
        _;
    }

    // txId是否已经被执行了
    modifier notExecuted(uint _txId){
        require(!transactions[_txId].executed, "tx already executed");
        _;
    }

    constructor(address[] memory _owners, uint _required){
        require(_owners.length > 0 ,"owners required");
        require(_required > 0 && _required <= _owners.length, "invalid required number of owners");

        for(uint i=0; i < _owners.length; i++){
            address owner = _owners[i];
            // check address invalid
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner is not unique");

            isOwner[owner] = true;
            owners.push(owner);
        }
        required = _required;
    }

    // 接收主币
    receive() external payable{
        emit Deposit(msg.sender, msg.value);
    }


    // 提交一个交易申请
    function submit(address _to, uint _value, bytes calldata _data) 
        external onlyOwner 
    {
        transactions.push(Transaction({
            to: _to,
            value: _value,
            data: _data,
            executed: false
        }));
        // txId = txs index
        emit Submit(transactions.length - 1);
    }

    // 审批交易
    function approve(uint _txId) 
        external onlyOwner txExists(_txId) notApproved(_txId) notExecuted(_txId)
    {
        approved[_txId][msg.sender] = true;
        emit Approve(msg.sender, _txId);
    }

    // 内部方法，拿到审批的数量
    function _getApprovalCount(uint _txId) private view returns(uint count){
        for(uint i = 0; i< owners.length; i++){
            if(approved[_txId][owners[i]]){
                count += 1;
            }
        }
    }

    // 执行call
    function execute(uint _txId) external txExists(_txId) notExecuted(_txId){
        require(_getApprovalCount(_txId) >= required, "approval < required");
        Transaction storage transaction = transactions[_txId];
        transaction.executed = true;
        // to execute
        (bool success, ) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx execute failed");
        emit Execute(_txId);
    }

    // 撤销审批
    function revoke(uint _txId) external onlyOwner txExists(_txId) notExecuted(_txId){
        // approved的tx才能被revoke
        require(approved[_txId][msg.sender], "tx not approved");
        approved[_txId][msg.sender] = false;
        emit Revoke(msg.sender, _txId); 
    }
}