// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Pagaveis{

    event Transference(address indexed _from, address indexed _to, uint amount);

    function deposit() external payable returns(bool){
        require(msg.value >= 1 ether, "Nao existe");
        return true;
    }

    function balance() external view returns(uint256){
        return address(this).balance;
    }

    function transferToMsg(address _to) external payable returns(bool){
        uint amount = msg.value;
        require(amount >= 10 wei, "Apenas operacoes maiores que 10 wei's");
        require(payable(_to).send(amount),"transferencia nao feita");
        emit Transference(msg.sender,_to,amount);
        return true;
    }

    function withdrawSend(uint256 _amount) external returns(bool){
        if(payable(msg.sender).send(_amount)){
            return true;
        }else{
            return false;
        }
    }

    function withdrawTransfer(uint256 _amount, address payable _endereco) external{
        _endereco.transfer(_amount);
    }
}