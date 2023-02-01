// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

interface Ioperacoes{
    function soma(uint a, uint b) external pure returns(uint256);
    function subtracao(uint a) external view returns(uint256);
}

abstract contract Aoperacoes is Ioperacoes{

    function multiplicacao(uint c) public view virtual returns(uint256);
    function divisao() public virtual {}
}

abstract contract operacoes is Aoperacoes{
     uint256 res;
     uint256 a = 2;
     uint256 b = 2;

    function multiplicacao(uint c) public view override returns(uint256){
        return a*c;
    }

    function divisao() public override{
        res = a/b;
    }

    function viewRes() public view returns(uint256){
        return res;
    }
}
