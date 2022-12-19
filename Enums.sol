// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Categorias{
    enum ESTADO {ATIVO, INATIVO, CANCELADO, CADASTRADO}

    mapping(address => ESTADO) usuarios;

    function addUser() external {
        usuarios[msg.sender] = ESTADO.CADASTRADO;
    }

    function getUser() external view returns(ESTADO){
        return usuarios[msg.sender];
    }

    function calcula(uint _a, uint _b) external returns(uint){
        require(usuarios[msg.sender] == ESTADO.CADASTRADO, "Usuario nao cadastrado");

        uint resultado = _a + _b;
        usuarios[msg.sender] = ESTADO.ATIVO;
        return resultado;
    }
}