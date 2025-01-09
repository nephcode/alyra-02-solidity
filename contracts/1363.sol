// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

// Import ERC-20 standard depuis OpenZeppelin
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

// Import ERC-20 Burnable
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// Import ERC-20 Pausable
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Pausable.sol";

// Import ERC-1363 Standard (si disponible dans un repository compatible)
import "https://github.com/vittominacori/erc1363-payable-token/blob/master/contracts/token/ERC1363/ERC1363.sol";


contract Rethagon13 is ERC1363, ERC20Burnable, ERC20Pausable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply
    ) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply * (10 ** decimals()));
    }

    /**
     * @dev Pauses all token transfers.
     * Only the owner can call this function.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Unpauses all token transfers.
     * Only the owner can call this function.
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Override _beforeTokenTransfer to include pausable functionality.
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }
}