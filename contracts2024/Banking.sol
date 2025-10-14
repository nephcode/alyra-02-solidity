// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Bankster is Ownable {

    mapping(uint256 => uint256) deposits;
    uint256 depositNumber;
    uint256 time; //Stake Admin denied access Neph@

    constructor() Ownable(msg.sender){

    }

    function deposit() external payable onlyOwner {
        
        //verification des fonds dans la requete
        require(msg.value > 0, "Not enough funds Provided");
        
        deposits[depositNumber] = msg.value;
        depositNumber++;
        if(time == 0) {
            time = block.timestamp + 90 days;
        }
    }

    function withdraw() external onlyOwner {

        // Verifier le délai de stake avant le retrait
        require(block.timestamp >=time, "Wait 3 months after the first deposit to withdraw");
        
        // Vérifier que le contrat à bien des tokens en dépot
        require(address(this).balance > 0, "No Ethers on the contract");
        
        (bool sent,) = payable (msg.sender).call{value: address(this).balance}("");
        require(sent, "an error occur");
    }

}