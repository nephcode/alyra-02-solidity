// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Test {
    struct Apprenant {
        string name;
        uint256 note;
    }
    Apprenant[] apprenants;

    function addApprenant(string memory _name, uint256 _note) external {
        // memoire tampon 
        Apprenant memory newApprenant = Apprenant(_name, _note);
        
        // Mettre dans la table
        apprenants.push(newApprenant);
    }


}

contract TestPublic {

    uint[] public number;

    function addNumber(uint256 _number) public {
        number.push(_number);
    }

    function updateNumber(uint256 _index, uint256 _number) public {
        number[_index] = _number;
    }

    function deleteValue(uint256 _index) public {
        delete number[_index];
    }  

    function howMany() public view returns(uint256) {
        return number.length;
    }   




}