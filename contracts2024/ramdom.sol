// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Ramdom {

    uint nonce;

    function random () public returns (uint){
        nonce ++;
        return uint(keccak256(
           abi.encodePacked(nonce, block.timestamp)
        )) % 100;
    }

}