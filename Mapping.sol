// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract mappings{
    mapping(address => uint) saldos;
    mapping(address => uint[]) pontuacao;

    function deposito() external payable{
        saldos[msg.sender] += msg.value;
    }

    function balanceOf() external view returns(uint256){
        return saldos[msg.sender];
    }

    function salvaPontuacao(uint _pontos) external{
        pontuacao[msg.sender].push(_pontos);
    }

    function premio() external view returns(uint256){
        uint somaPontuacao;

        for(uint i; i < pontuacao[msg.sender].length;i++){
            somaPontuacao += pontuacao[msg.sender][i];
        }

        return somaPontuacao;
    }
}