// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyERC20Token
 * @dev An ERC20 token for testing purposes
 */
contract MyERC20Token is ERC20, Ownable {
    constructor() ERC20("MyERC20Token", "MET") {}

    /**
     * @dev Creates a new voting session
     */
    function createVotingSession() public onlyOwner {
        // implementation for creating a voting session
    }
}