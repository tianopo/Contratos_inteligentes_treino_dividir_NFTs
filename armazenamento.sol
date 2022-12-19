// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Armazenamento{
    string qualquerTexto;

    function lerNumero() public view returns (string memory){
        return qualquerTexto;
    }

    function guardaNumero(string memory _texto) public returns(string memory){
        qualquerTexto = _texto;
        uint qualquerNumero = 10;
    }
}