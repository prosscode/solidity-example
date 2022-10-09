// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
英式拍卖，正常的拍卖流程，价高者得
 */
interface IERC721{
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract EnglishAuction{
    // nft info
    IERC721 public immutable nft;
    uint public immutable nftId;

    // auction info
    address payable public seller;
    // 2^32
    uint32 public endAt;
    bool public started;
    bool public ended;

    // bidder info
    address public highestBidder;
    uint public highestBid;
    // need fund to bidder
    mapping(address => uint) public bids;

    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed sender, uint amount);
    event End(address highestBidder, uint amount);

    constructor(address _nft, uint _nftId, uint _startingBid){
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external{
        require(msg.sender == seller, "not seller");
        require(!started, "started");

        started = true;
        endAt = uint32(block.timestamp + 60); //60 s
        nft.transferFrom(seller, address(this), nftId);

        emit Start();
    }

    function bid() external payable{
        require(!started, "auction not started");
        require(block.timestamp < endAt, "auction ended");
        require(msg.value > highestBid, "value < highest bid");

        if(highestBidder != address(0)){
            bids[highestBidder] += highestBid;
        }

        // update
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    // 退回出价金额
    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    // 到时间后，任何人都可以end拍卖
    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;
        if(highestBidder != address(0)){
            // 交易成功
            nft.transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            // 如果没人出价，退回nft
            nft.transferFrom(address(this), seller, nftId);
        }
        emit End(highestBidder, highestBid);
    }
}