// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Evento{
    event Transferencia(address indexed _from, address indexed  _to, uint256 amount);

    function transfer(address _to, uint256 _amount) public{

        emit Transferencia(msg.sender, _to, _amount);
    }


}