// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GlobalVariables {
    address public owner;
    address public myblockhash;
    uint256 public difficulty;
    uint256 public gasLimit;
    uint256 public number;
    uint256 public timestamp;
    uint256 public value;
    uint256 public nowOn;
    address public origin; 
    uint256 public gasprice;
    bytes public callData;
    bytes4 public firstFour;

    constructor() {
        owner = msg.sender;

        myblockhash = block.coinbase;
        difficulty = block.difficulty;
        gasLimit = block.gaslimit;
        number = block.number;
        timestamp = block.timestamp;
        gasprice = tx.gasprice;
        origin = msg.sender; // Use msg.sender instead of tx.origin
        callData = msg.data;
        firstFour = msg.sig;
    }
}
