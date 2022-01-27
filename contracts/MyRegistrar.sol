//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract MyRegistrar is Ownable , ReentrancyGuard {
    mapping (address => bool) _paid;
    mapping (address => bytes32) _hashMap;
    mapping (bytes32 => address) _knownHashes;
    uint256 _price;

    
    constructor(uint256 price) Ownable() payable {
        _price = price;
    }

    function getPrice() public view returns (uint256) {
        return _price;
    }

    function setPrice(uint256 newPrice) public onlyOwner {
        _price = newPrice;
    }

    // need to figure out what to do here about stuck funds...
    function deposit() public payable {
        require(msg.value == _price, "wrong deposit amount");
        _paid[msg.sender] = true;
    }

    function hasHash(address addy) public view returns(bool) {
        return _hashMap[addy] != bytes32(0);
    }

    function getHash(address addy) public view returns(bytes32) {
        return _hashMap[addy];
    }

    function knownHash(bytes32 hash) public view onlyOwner returns(bool) {
        return _knownHashes[hash] != address(0x0);
    }

    function knownHashAddress(bytes32 hash) public view onlyOwner returns(address) {
        return _knownHashes[hash];
    }

    function paid(address addy) public view onlyOwner returns(bool) {
        return _paid[addy];
    }

    function addHash(address addy, bytes32 hash) public onlyOwner {
        require(_paid[addy] == true, "not paid");
        _hashMap[addy] = hash;
        _knownHashes[hash] = addy;

        // set to false to allow for reauthentications
        _paid[addy] = false;
    }

   // Function to withdraw all Ether from this contract.
    function withdraw(uint256 amt) public onlyOwner {
        require(amt <= address(this).balance, "insufficient balance");
        // get the amount of Ether stored in this contract

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success, ) = owner().call{value: amt}("");
        require(success, "Failed to send Ether");
    }

    function balance() public view onlyOwner returns(uint256) {
        return address(this).balance;
    }

}
