// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract hi{
    address private sender = msg.sender;
    uint256 private quant;

    error InsufficientBalance(uint balance, uint withdrawAmount);

    function getNumber() public view returns(uint256){
        return quant;
    }

    function deposit() public payable{
        require(msg.value > 0,"Insuficient balance");
    }

    function withdraw(uint _withdrawAmount) public payable {
        uint bal = address(this).balance;

        if (bal < _withdrawAmount) {
            revert InsufficientBalance({balance: bal, withdrawAmount: _withdrawAmount});
        }

        payable(sender).transfer(_withdrawAmount);
    }

    function luckNumber(uint256 amount) public{
        assert(amount > 0);
        quant = amount;
    }
}
