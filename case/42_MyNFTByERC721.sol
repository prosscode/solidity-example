// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./41_IERC721.sol";

contract MyNFT is ERC721 {

    // 铸造nft，铸造地址就是当前部署默认地址
    function mint(address to, uint id) external {
        _mint(to, id);
    }

    function burn(uint id) external {
        require(msg.sender == _ownerOf[id], "not owner");
        _burn(id);
    }
}