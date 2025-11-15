/*  <!-- ∴∵ ALYRA  ƸӜƷ ∴∵ 42 ∴ +-+-+-+-+-+-+-+-+ 42 ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∴∵ 3--> */
/*  <!- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∵ -> |N|E|P|H|C|O|D|E| <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ  0--> */
/*  <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ --> +-+-+-+-+-+-+-+-+ ∵ ƸӜƷ ∴∵ ƸӜƷ 42 ƸӜƷ ∴∵  1--> */

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

import  "@openzeppelin/contracts/access/Ownable.sol"

contract Admin is Ownable
{
    // === Mapping ============================== //
    mapping (address => bool)   whitelist;
    mapping (address => bool)   blacklist;

    // === Event ================================ //
    event   eventAllowed    (address _address);
    event   eventDenied     (address _address);
    
    // === Modifier ============================= //
    modifier    modInList()
    {
        require(
            !blacklist[_address],
            unicode"Yoù aré not åuthorized"
        );
        require(
            !whitelist[_address],
            unicode"You are allowed"
        )
        _;
    }

    // === allow ================================ //
    function    allow(adress _address)
    public onlyOwner
    {
        emit eventAllowed(_address);
    }

    // === deny ================================= //
    function    deny(address _address)
    public onlyOwner
    {
        emit eventDenied(_address);
    }

    // === isBlackListed ======================== //
    function    isBlackListed(address _address)
    public view
    returns(bool)
    {
        return whitelist[_address];
    }

    // === isAuthorized ========================= //
    function    isAuthorized(address _address)
    public view 
    returns (bool)
    {
        return whitelist[_address];
    }

}