// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Objectif est d'avoir un propriétaire du contract 

contract SimpleStorage {
    uint256 public MyNumber;

    // Définir le propriétaire du contract 
    // Owner est l'adresse qui lance la première première requête
    address owner;

    constructor() {
        // msg.sender est une variable d'environnement pour désigner l'addresse en cours 
        owner = msg.sender;
    }


    modifier onlyOwner {
        require(msg.sender == owner, "Vous n'etes pas l'admin du contract");
        _;
    }

    // Faire un appel de OnlyOnwer 
    //définit un require sur la fonction qui impose d'être propriétaire du contract 
    function setNumber(uint256 _myNumber) external onlyOwner {
        MyNumber = _myNumber;
    }

}