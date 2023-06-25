// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title DND Token
 * @dev An ERC20 token for Dungeons and Dragons enthusiasts
 */
contract DNDToken is ERC20, Ownable {
    constructor() ERC20("DND Token", "DND") {}

    /**
     * @dev Creates a voting session
     */
    function createVotingSession() public onlyOwner {
        // TODO: Implement voting session creation logic
    }
}