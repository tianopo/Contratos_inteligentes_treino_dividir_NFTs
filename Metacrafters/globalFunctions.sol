// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract globalFunction{
    uint256 private _thisContract = address(this).balance;
    uint256 private _value;
    uint256 private _hard = block.difficulty; //Retorna a dificuldade no momento em que o bloco atual foi extraído
    uint256 private _timestamp = block.timestamp; //Retorna o carimbo de data/hora em que o bloco atual foi extraído
    uint256 private _gaslimit = block.gaslimit; //Retorna o gaslimit total de todas as transações mineradas no bloco atual
    uint256 private _number = block.number; //Retorna o número do bloco mais novo no blockchain
    uint256 private _gasprice = tx.gasprice; //Retorna o preço do gás da transação enviado pelo remetente como parte da transação
    address private _admin = msg.sender;
    address private _coinbase = block.coinbase; //Retorna o endereço do minerador em vez do bloco atualmente minerado
    address private _origin = tx.origin; //Retorna o endereço do remetente original da transação


    function thisContract() public view returns(uint256){
        return _thisContract;
    }

    function value() public view returns(uint256){
        return _value;
    }

    function hard() public view returns(uint256){
        return _hard;
    }

    function timestamp() public view returns(uint256){
        return _timestamp;
    }

    function gaslimit() public view returns(uint256){
        return _gaslimit;
    }

    function number() public view returns(uint256){
        return _number;
    }

    function gasprice() public view returns(uint256){
        return _gasprice;
    }

    function admin() public view returns(address){
        return _admin;
    }

    function coinbase() public view returns(address){
        return _coinbase;
    }

    function origin() public view returns(address){
        return _origin;
    }

    function transferTo(uint256 amount) public payable{
        payable(admin()).transfer(amount);
        //admin().transfer(amount);
    }

    function testCallDoesNotExist(address payable _addr) public payable {
        (bool success, bytes memory data) = _addr.call{value: value()}(
            abi.encodeWithSignature("doesNotExist()")
        );
    }


}
