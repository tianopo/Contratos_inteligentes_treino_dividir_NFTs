// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/utils/ERC721Holder.sol";


contract MyToken is ERC20, Ownable, ERC20Permit, ERC721Holder {
    IERC721 public collection;
    uint256 public tokenId;
    bool public initialized = false;
    bool public forSale = false;
    uint256 public salePrice;
    bool public canRedeem = false;

    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {}

    function initialize(address _collection, uint256 _tokenId, uint256 _amount) external onlyOwner{
        require(!initialized, "Ja inicializado");
        require(_amount > 0, "");
        collection = IERC721(_collection);
        collection.safeTransferFrom(msg.sender, address(this), _tokenId);
        tokenId = _tokenId;
        initialized = true;
        _mint(msg.sender, _amount);
    }

    function putForSale(uint256 price) external onlyOwner{
        salePrice = price;
        forSale = true;
    }

    function purchase() external payable{
        require(forSale,"Nao esta a venda");
        require(msg.value >=salePrice, "Sem dinheiro o suficiente");
        collection.transferFrom(address(this),msg.sender,tokenId);
        forSale = false;
        canRedeem = true;
    }

    function reedem(uint256 _amount) external{
        require(canRedeem, "Reembolso nao disponivel");
        uint256 totalEther = address(this).balance;
        uint256 toRedeem = _amount * totalEther / totalSupply();

        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(toRedeem);
    }
    //function mint(address to, uint256 amount) public onlyOwner {
    //    _mint(to, amount);
    //}
}