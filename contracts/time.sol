// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Time {
    function getTime() public view returns (uint){
        return block.timestamp;
    }

}