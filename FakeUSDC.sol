// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract FakeUSDC{
    string public name ="Fake USDC Coin";
    string public symbol = "USDC";
    uint8 public  decimals=6;
    uint256 public totalsupply;

    mapping (address => uint256) public balanceof;
    mapping (address => mapping (address => uint256)) public allowance;
    
    constructor(uint256 initialsupply){
        balanceof[msg.sender]= initialsupply;
        totalsupply=initialsupply;
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(balanceof[msg.sender] >= value, "Insufficient balance");
        balanceof[msg.sender] -= value;
        balanceof[to] += value;
        return true;
    }
     function approve(address spender, uint256 value) external returns (bool) {
        allowance[msg.sender][spender] = value;
        return true;
    }
    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        require(balanceof[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Not allowed");

        allowance[from][msg.sender] -= value;
        balanceof[from] -= value;
        balanceof[to] += value;

        return true;
    }
}


