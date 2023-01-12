// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract functionErros{
    address private sender = msg.sender;
    uint256 private quant;

    error InsufficientBalance(uint balance, uint amount);

    function getNumber() public view returns(uint256){
        return quant;
    }

    function deposit() public payable{
        require(msg.value > 0,"Insuficient balance");
    }

    function withdraw(uint _amount) public payable {
        uint balance = address(this).balance;

        if (balance < _amount) {
            revert InsufficientBalance({balance: balance, amount: _amount});
        }

        payable(sender).transfer(_amount);
    }

    function luckNumber(uint256 amount) public{
        assert(amount > 0);
        quant = amount;
    }
}
