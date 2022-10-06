// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
0. message to sign
1. hash(message)
2. sign(hash(message),private key)  - offchain
    get account  = ethereum.request({ method: 'eth_requestAccounts' })
    offchain get hash by account = ethereum.request({ method: 'personal_sign', params: [account, hash]})
3. ecrecover(hash(message),signature) == signer

summarise 
verify -> 能够通过签名地址（address），消息（message）和签名信息（_signature），验证是否一致
getMessageHash + getEthSignedMessage -> message 2 hash

 */
contract VerifySign{

    /**
    _address: account
    _message: hash message
    _signature: singature
     */
    function verify(address _address, string memory _message, bytes memory _signature) 
        external pure returns (bool)
    {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessage(messageHash);
        return recover(ethSignedMessageHash, _signature) == _address;
    }

    function getMessageHash(string memory _message) public pure returns(bytes32){
        return keccak256(abi.encodePacked(_message));
    }

    // 一次hash在数学界被证实有可能被伪造
    function getEthSignedMessage(bytes32 _messageHash) public pure returns(bytes32){
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }


    function recover(bytes32 _ethSignedMessageHash, bytes memory _signature) 
        public pure returns(address)
    {
        (bytes32 r, bytes32 s, uint8 v) = _split(_signature);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    function _split(bytes memory _signature) internal pure returns(bytes32 r,bytes32 s,uint8 v){
        require(_signature.length==65,"invalid signature length");
        // split
        assembly{
            r := mload(add(_signature,32))
            s := mload(add(_signature,64))
            v := byte(0,mload(add(_signature,96)))
        }
        // return (r,s,v)
    }
}