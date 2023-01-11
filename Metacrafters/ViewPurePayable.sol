// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract viewPurePayable{
    uint8 y = 2;
    address x = msg.sender;

    function xView(uint a) public view returns(uint256){
        return y + a;
    }

    function xPure(uint b, uint c) public pure returns(uint256){
        return b + c;
    }

    function xpayable()public payable{
        payable(x).transfer(xPure(3,6) + xView(10));
    }
}
