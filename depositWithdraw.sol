// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CrowdFunding{

    address private owner;
    uint256 private balance;

    mapping(address => uint256) private saldos;

    event DepositCreated(address indexed _to, uint256 indexed _amount);

    event WithdrawCreated(address indexed _to, uint256 _amount);

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "not owner");
        _;
    }

    modifier Insufficient(address _to, uint256 _amount){
        require(saldos[_to] == _amount,"Insufficient balance");
        _;
    }

    function deposit() external payable{
        
        balance += msg.value;

        emit DepositCreated(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount, address _to) public payable onlyOwner{

        payable(_to).transfer(_amount);
        emit WithdrawCreated(_to, _amount);
    }

    function saldo(address _address)public view returns (uint256) {
        return address(_address).balance;
    }
}