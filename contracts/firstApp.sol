//SPDX-License-=Identifier: MIT
pragma solidity ^0.8.13;

contract NFTCount{

    uint256 public numberOfNFT;

    function checkTotalNFT() public view returns(uint256){
        return numberOfNFT;
    }

    function addNFT() public{
        numberOfNFT += 1;
    }

    function deleteNFT() public{
        numberOfNFT -= 1;
    }
}