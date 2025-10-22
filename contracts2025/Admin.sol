/*  <!-- ∴∵ ALYRA  ƸӜƷ ∴∵ 42 ∴ +-+-+-+-+-+-+-+-+ 42 ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∴∵ 3--> */
/*  <!- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∵ -> |N|E|P|H|C|O|D|E| <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ  0--> */
/*  <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ --> +-+-+-+-+-+-+-+-+ ∵ ƸӜƷ ∴∵ ƸӜƷ 42 ƸӜƷ ∴∵  1--> */

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import  "@openzeppelin/contracts/access/Ownable.sol"

contract Admin is Ownable
{
    mapping (address => bool)   whitelist;
    mapping (address => bool)   blacklist;

    event   eventAuthorized   (address _address);
    event   eventBanned       (address _address);

    constructor(onlyOwner
    )

    modifier    mod

    function    isBlackListed()
    public 
    returns()
    {}

    function    isAuthorized()
    public 
    returns ()
    {}

}