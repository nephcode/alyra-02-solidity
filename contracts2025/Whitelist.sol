/*  <!-- ∴∵ ALYRA  ƸӜƷ ∴∵ 42 ∴ +-+-+-+-+-+-+-+-+ 42 ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∴∵ 3--> */
/*  <!- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∵ -> |N|E|P|H|C|O|D|E| <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ  0--> */
/*  <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ --> +-+-+-+-+-+-+-+-+ ∵ ƸӜƷ ∴∵ ƸӜƷ 42 ƸӜƷ ∴∵  1--> */

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Whitelist {
    // event generated logs 
    event Authorired(address _address);

    // classic whitelist
    mapping (address => bool) whiteList;

    function authorized(address _address)
    public 
    {
        whitelist(_address);    
        emit Authorired(_address);
    }

}   