// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract numero{
    uint256 public value;
    address private sender;
    uint256 private num;

    function newNumber(uint256 _num) public payable{
        value = msg.value;
        sender = msg.sender;
        num = _num;
    }
}

contract proxy{
    uint256 public value;
    address private sender;
    uint256 private num;

    function newNumber(address _contract, uint256 _num) public payable returns (bool,bytes memory){

        (bool right, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)",_num)
        );
        return(right, data);
    }
}
