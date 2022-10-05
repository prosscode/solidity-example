// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
什么样的合约叫做ERC20标准合约 - 只要满足IERC20接口的合约，实现了标准中所列出的方法

接口合约中的方法定义:
1.totalSupply(), 当前合约的token总量
2.balanceOf(),某一个账户的当前余额
3.transfer(), 把账户的余额由当前调用者发送到另一个账户中, 需要汇报事件
4.allowance(), 可以查询某一个账户对另一个账户的批准额度有多少
5.approve(), 批准方法，把当前调用者的账户的数量批准给另一个账户，可以通过allowance()查询
6.transferFrom(), 当前调用者可以指定从一个合约账户Token转入另一个合约账户
*/ 
interface IERC20{
    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed spender, uint amount);

    function totalSupply() external returns(uint);

    function balanceOf(address account) external returns(uint);

    function transfer(address recipient, uint amount) external returns(bool);

    function allowance(address owner, address spender) external view returns(uint);

    function approve(address spender, uint amount) external returns(bool);

    function transferFrom(address sender, address recipient, uint amount) external returns(bool);

}

contract ERC20 is IERC20{
    uint public override totalSupply;
    mapping(address=>uint) public override balanceOf;
    mapping(address=>mapping(address=>uint)) public override allowance;
    string public name = "Test";
    string public symbol = "TEST";
    uint public decimals = 18;

    address private owner;

    modifier onlyRole(address _account){
        require(_account == owner, "only contract onwer to mint");
        _;
    }

    constructor(){
        owner = msg.sender;
    }
    // 铸币方法（需要加权限）
    function mint(uint amount) external onlyRole(msg.sender) returns(bool){
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
        return true;
    }

    function transfer(address recipient, uint amount) external override returns(bool){
        require(allowance[msg.sender][recipient] >= amount, "allowance recipient < amount");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }


    function approve(address spender, uint amount) external override returns(bool){
        require(balanceOf[msg.sender] >= amount,"sender token < approve amount");
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }


    function transferFrom(address sender, address recipient, uint amount) external override returns(bool){
        require(allowance[sender][msg.sender]>=amount,"msg sender allowance < amount");
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function burn(address _someone, uint amount) external {
        balanceOf[msg.sender] -= amount;
        totalSupply  -= amount;
        emit Transfer(msg.sender, _someone, amount);
        selfdestruct(payable(_someone));
    }

}