// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract memorizer{
    //storage are all variables and arrays delcared outside of the function, it is mroe expensive.
    string public name;
    string public number;

    //calldata memory is temporary,it cannot be modified and it is cheaper, generally pure functions is used and strings
    function yourName(string calldata a)public pure returns(string calldata){
        return a; 
    }

    //memory is also temporary, I can modify the string.
    function ourName(string memory a)public returns(string memory){
        name = a;
        return name; 
    }
}
