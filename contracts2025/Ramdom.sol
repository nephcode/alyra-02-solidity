// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Ramdom 
{
    uint nonce;
    function random   ()
    public 
    returns (uint)
    {
        // not secure but nice to understand keccak
        nonce ++;
        return uint(keccak256(abi.encodePacked(nonce, block.timestamp))) % 100;
    }
}