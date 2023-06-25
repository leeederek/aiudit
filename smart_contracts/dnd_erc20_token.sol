// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DND ERC20 Token
 * @dev This is an ERC20 token for Dungeons and Dragons players on the Gnosis Chiado network.
 */
contract DNDToken is ERC20, Ownable {
    constructor() ERC20("DND Token", "DND") {}

    /**
     * @dev Creates a voting session.
     */
    function createVotingSession() public onlyOwner {
        // TODO: Implement voting session creation logic
    }
}