// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ERC20Token
 * @dev Implementation of the ERC20 token standard with 'override' specifiers for the overridden functions.
 */
contract ERC20Token is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {}

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20) {
        super._beforeTokenTransfer(from, to, amount);
    }

    function _afterTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20) {
        super._afterTokenTransfer(from, to, amount);
    }

    function _beforeTokenTransfer(address operator, address from, address to, uint256 amount) internal virtual override(ERC20) {
        super._beforeTokenTransfer(operator, from, to, amount);
    }

    function _mint(address account, uint256 amount) internal virtual override(ERC20) {
        super._mint(account, amount);
    }

    function _burn(address account, uint256 amount) internal virtual override(ERC20) {
        super._burn(account, amount);
    }

    function _approve(address owner, address spender, uint256 amount) internal virtual override(ERC20) {
        super._approve(owner, spender, amount);
    }
}

/**
 * @title VotingApp
 * @dev A voting app with an owner that can create a voting session.
 */
contract VotingApp is Ownable {
    struct VotingSession {
        string name;
        uint256 startTime;
        uint256 endTime;
        mapping(address => bool) hasVoted;
        mapping(address => bool) votes;
        uint256 yesVotes;
        uint256 noVotes;
        bool isActive;
    }

    mapping(uint256 => VotingSession) public votingSessions;
    uint256 public votingSessionCount;

    event VotingSessionCreated(uint256 indexed sessionId, string name, uint256 startTime, uint256 endTime);
    event VoteCast(uint256 indexed sessionId, address indexed voter, bool vote);

    /**
     * @dev Creates a new voting session.
     * @param name The name of the voting session.
     * @param startTime The start time of the voting session.
     * @param endTime The end time of the voting session.
     */
    function createVotingSession(string memory name, uint256 startTime, uint256 endTime) public onlyOwner {
        require(startTime < endTime, "Invalid voting session times");
        votingSessionCount++;
        votingSessions[votingSessionCount] = VotingSession(name, startTime, endTime, false, false, 0, 0, true);
        emit VotingSessionCreated(votingSessionCount, name, startTime, endTime);
    }

    /**
     * @dev Casts a vote in a voting session.
     * @param sessionId The ID of the voting session.
     * @param vote The vote to cast (true for yes, false for no).
     */
    function castVote(uint256 sessionId, bool vote) public {
        require(votingSessions[sessionId].isActive, "Voting session is not active");
        require(block.timestamp >= votingSessions[sessionId].startTime, "Voting session has not started");
        require(block.timestamp <= votingSessions[sessionId].endTime, "Voting session has ended");
        require(!votingSessions[sessionId].hasVoted[msg.sender], "Already voted in this session");

        votingSessions[sessionId].hasVoted[msg.sender] = true;
        votingSessions[sessionId].votes[msg.sender] = vote;

        if (vote) {
            votingSessions[sessionId].yesVotes++;
        } else {
            votingSessions[sessionId].noVotes++;
        }

        emit VoteCast(sessionId, msg.sender, vote);
    }
}