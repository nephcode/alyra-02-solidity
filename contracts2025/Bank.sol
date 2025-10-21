// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Bank
{
    mapping (address => uint) balances;

    function deposit(uint _amount)
    public payable 
    {
        balances[msg.sender]+_amount;
    }

    function transfer(address _recipient, uint _amount)
    public payable 
    {
        require (_recipient != address(0), "Burn is not authorized");
        require (balances[msg.sender]>=_amount, "Not enough Tokens");
        balances[msg.sender]-=_amount;
        balances[_recipient]+=_amount;
    }

    function balanceOf(address _address)
    public view 
    returns (uint)
    {
        return balances[_address];
    }

}