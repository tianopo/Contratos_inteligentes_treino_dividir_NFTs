// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

interface IERC20 {

    function name() external view returns (string memory);

    function symbol() external view returns (string memory);

    function goal() external view returns (uint256);

    function decimals() external view returns (uint8);

    function totalSupply() external view returns (uint256);

    //Returns the amount of tokens owned by `account`.
    function balanceOf(address account) external view returns (uint256);

    function investment() external payable;

    function refund() external payable;

    function getFinance() external payable;

    function _beforeTokenTransfer() external;

}

contract ERC20 {
    mapping (address => uint256) private _balances;

    uint256 private _goal;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    address private admin;
    address private _sender = msg.sender;

    IERC20 private erc;

    event InvestmentDone(address indexed _from, uint256 indexed _amount);

    event RefundDone(address indexed _to, uint256 _amount);

    event FinanceCreated(address indexed _to, uint256 _amount);

    modifier onlyOwner(){
        require(msg.sender == _sender, "not owner");
        _;
    }
    
    function upgrade(address _erc) external onlyOwner{
        erc = IERC20(_erc);
    } 

    // Returns the name of the token.
    function name() public view virtual returns (string memory) {
        return erc.name();
    }

     // Returns the symbol of the token.
    function symbol() public view virtual returns (string memory) {
        return erc.symbol();
    }

    // Returns the amount to reach the goal.
    function goal() public view virtual returns (uint256){
        return erc.goal();
    }
    
    //Returns the number of decimals used to get its user representation.
    function decimals() public view virtual returns (uint8) {
        return erc.decimals();
    }

    // See {IERC20-totalSupply}.
    function totalSupply() public view virtual returns (uint256) {
        return erc.totalSupply();
    }

    // See {IERC20-balanceOf}.
    function balanceOf(address account) public view virtual returns (uint256) {
        return erc.balanceOf(account);
    }

    function investment() public payable{
        require(msg.value > 0,"Insuficient balance to invest");

        _totalSupply += msg.value;
        _balances[_sender] += msg.value;

        emit InvestmentDone(_sender, _balances[_sender]);
    }

    //The Ethereum balance is refunded with tokens, the tokens are pratically burned.
    function refund() public payable{
        require(_totalSupply >= _balances[_sender] && _totalSupply != 0 && _balances[_sender] > 0,"Insuficient balance to refund");
        require(_goal > _totalSupply,"You reached the goal");

        _beforeTokenTransfer();

        payable(_sender).transfer(_balances[_sender]);

        _totalSupply -= _balances[_sender];
        _balances[_sender] -= _balances[_sender];

        emit RefundDone(_sender, _balances[_sender]);
    }

    function getFinance() public payable onlyOwner{
        require(_goal <= _totalSupply,"You didn't reach the goal");

        payable(admin).transfer(_totalSupply);

        _totalSupply -= _totalSupply;
        
        emit FinanceCreated(admin, _totalSupply);
    }

    //Hooks are to include some information before the investor put his money in the finance project, this is optional.
    function _beforeTokenTransfer() public {

    }
}

contract V1 {
    mapping (address => uint256) private _balances;

    uint256 private _goal;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    address private admin;
    address private _sender = msg.sender;

    constructor (string memory name_, string memory symbol_, uint256 goal_) {
        _name = name_;
        _symbol = symbol_;
        _goal = goal_ * 10**uint(decimals());
        admin = _sender;
    }

    modifier onlyOwner(){
        require(admin == _sender, "not owner");
        _;
    }

    // Returns the name of the token.
    function name() public view virtual returns (string memory) {
        return _name;
    }

     // Returns the symbol of the token.
    function symbol() public view virtual returns (string memory) {
        return _symbol;
    }

    // Returns the amount to reach the goal.
    function goal() public view virtual returns (uint256){
        return _goal;
    }
    
    //Returns the number of decimals used to get its user representation.
    function decimals() public view virtual returns (uint8) {
        return 18;
    }

    // See {IERC20-totalSupply}.
    function totalSupply() public view virtual returns (uint256) {
        return _totalSupply;
    }

    // See {IERC20-balanceOf}.
    function balanceOf(address account) public view virtual returns (uint256) {
        return _balances[account];
    }
}
