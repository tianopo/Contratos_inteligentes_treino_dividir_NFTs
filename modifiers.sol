// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract modificadores{
    uint supply = 10;
    address admin = msg.sender;

    function getSupply() external view returns(uint){
        return supply;
    }

    function mint(uint _valor) external onlyAdmin somenteValor(_valor){
        supply += _valor;
    }

    modifier onlyAdmin(){
        require(msg.sender == admin,"Nao e o admin");
        _;
    }

    modifier somenteValor(uint _valor){
        require(_valor == 10,"nao e igual a 10;");
        _;
    }
}