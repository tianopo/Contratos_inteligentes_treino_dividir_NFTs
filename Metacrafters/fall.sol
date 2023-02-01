// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract fall{
    address payable public owner;
    uint public n;
    mapping(address => uint) balance;

    constructor() payable{
        owner = payable(msg.sender);
        n = msg.value;
    }

    function deposit() public payable {}

    receive() external payable{
        balance[owner] += n;
    }

    function value() public view returns(uint256){
        return address(this).balance;
    }
}
