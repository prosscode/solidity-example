// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
AccessControl, grant and revoke role with permission
 */
contract AccessControl{

    event GrantRole(bytes32 indexed role,address indexed account);
    event RevokeRole(bytes32 indexed role,address indexed account);
     
     // role -> account -> bool
    mapping(bytes32 => mapping(address=>bool)) public roles;
     
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    constructor(){
        _grantRole(ADMIN, msg.sender);
    }

    // check permission
    modifier onlyRole(bytes32 _role){
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 role, address account) external onlyRole(ADMIN){
        _grantRole(role, account);
    }

    function revokeRole(bytes32 role, address account) external onlyRole(ADMIN){
        roles[role][account] = false;
        emit RevokeRole(role, account);
    }

}