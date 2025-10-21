/*  <!-- ∴∵ ALYRA  ƸӜƷ ∴∵ 42 ∴ +-+-+-+-+-+-+-+-+ 42 ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∴∵ 3--> */
/*  <!- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ ∵ -> |N|E|P|H|C|O|D|E| <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ  0--> */
/*  <!-- ƸӜƷ ∴∵ ƸӜƷ ∴∵ ƸӜƷ --> +-+-+-+-+-+-+-+-+ ∵ ƸӜƷ ∴∵ ƸӜƷ 42 ƸӜƷ ∴∵  1--> */

// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Whitelist {
     // classic whitelist
    mapping (address => bool) whiteList;
    
    // event generated logs 
    event eventAuthorized(address _address);
    event eventReceived(address _target, uint _value);

    function authorized(address _address)
    public 
    {
        whiteList[_address] = true;   
        emit eventAuthorized(_address);
    }

    receive()
    external payable
    {
        emit eventReceived(msg.sender, msg.value);
    }

    fallback()
    external payable
    {
        emit eventReceived(msg.sender, msg.value);
    }
}   