// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
荷兰拍卖: 从起拍价开始，随着时间的流逝，价格越来越低
谁最先出价，谁可以得到藏品 <=> NFT

NFT拍卖流程：
1.铸造NFT，mint，MyNFT
2.允许拍卖，approve，ERC721
3.开始拍卖，getPrice and buy，DutchNFTAuction
4.查看归属，ownerOf，ERC721
 */
interface IERC721{
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract DutchNFTAuction{
    uint private constant DURATION = 1 hours;

    IERC721 public immutable nft;
    // 一个合约拍卖，对应一个nft藏品，对应一个nft id
    uint public immutable nftId;
    // nft销售者
    address payable public immutable seller;
    // 起拍价格
    uint public immutable startingPrice;
    // 开始时间
    uint public immutable startAt;
    // 过期时间
    uint immutable expireAt;
    // 每秒价格折扣率
    uint public immutable discountRate;

    constructor(uint _startingPrice, uint _discountRate, address _nft, uint _nftId){
        // 销售者=部署者
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        // 开始时间 = 区块时间
        startAt = block.timestamp;
        expireAt = block.timestamp + DURATION;
        // 价格不能为负数
        require(_startingPrice >= _discountRate * DURATION, "starting price < discount * duration");
        // NFT构造 
        nft = IERC721(_nft);
        nftId = _nftId;
    }

    // 获取价格
    function getPrice() public view returns (uint) {
        uint timeElapsed = block.timestamp - startAt;
        uint discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expireAt, "auction expired");
        uint price = getPrice();
        require(msg.value >= price, "ETH < current auction price");
        // 交易NFT
        nft.transferFrom(seller, msg.sender, nftId);
        uint refund = msg.value - price;
        // 多余的金额需要退回
        if(refund > 0){
            payable(msg.sender).transfer(refund);
        }
        // 采用self destruct方法，发送此次交易所得的主币给出售者
        selfdestruct(payable(seller));
    }
}