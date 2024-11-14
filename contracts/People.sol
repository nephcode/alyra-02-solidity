// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract People {

    struct Person {
        string name;
        uint age; 
    }

    Person public moi;

    function modifyPerson (string memory _name, uint _age ) public {
        moi = Person(_name, _age);
    }
}