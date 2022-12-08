// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract newCripto{
    address private owner;
    string internal tokenName;
    string internal symbolName;

    constructor(string memory _tokenName, string memory _symbolName){
        owner = msg.sender;
        tokenName = _tokenName;
        symbolName = _symbolName;
    }

    mapping(address => uint256) saldo;
    mapping(uint256 => string) URI;

    event DepositCreated(address indexed _to, uint256 indexed _amount);

    function depositToken(address _to, uint256 _amount) external{
        uint256 wallet = _amount;
        saldo[_to] +=  wallet;

        emit DepositCreated(_to, wallet);
    }

    function transfer(address _from, address _to, uint256 _amount)public{
        require(saldo[_from] > 0 || saldo[_from] >= _amount, "Saldo insuficiente");

        uint256 amount = _amount;
        saldo[_from] -= amount;
        saldo[_to] += amount;
    }

    function viewToken(address _from) external view returns(uint256){
        return saldo[_from];
    }

    function TokenView() public view returns(string memory,string memory){
        return (tokenName, symbolName);
    }
}