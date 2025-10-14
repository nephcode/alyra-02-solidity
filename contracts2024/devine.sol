// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/access/Ownable.sol";
error UserHasAlreadyPlayed(address user);
error GameFinished();

contract GuessAndWin is Ownable {
    string private word;
    string private indication;
    address winner;
    mapping(address => bool) hasPlayed;

    event GameWon(address indexed _winner);

    constructor() Ownable(msg.sender) {}

    function guess(string memory _word) external returns(bool) {
        if(hasPlayed[msg.sender]) {
            revert UserHasAlreadyPlayed(msg.sender);
        }
        if(winner != address(0)) {
            revert GameFinished();
        }
        if(compareString(word, _word)) {
            winner = msg.sender;
            hasPlayed[msg.sender] = true;
            emit GameWon(msg.sender);
            return true;
        }
        hasPlayed[msg.sender] = true;
        return false;
    }

    function setWordAndIndication(string memory _word, string memory _indication)
        external onlyOwner {
        word = _word;
        indication = _indication;
    }

    function compareString(string memory _string1, string memory _string2)
        internal pure returns(bool) {
        return keccak256(abi.encodePacked(_string1)) == keccak256(abi.encodePacked(_string2));
    }

    function getIndication() external view returns(string memory) {
        return indication;
    }

    function getWinner() external view returns(address) {
        return winner;
    }
}