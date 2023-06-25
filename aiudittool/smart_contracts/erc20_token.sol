// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ERC20Token
 * @dev A standard ERC20 token contract
 */
contract ERC20Token is ERC20 {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }
}

/**
 * @title VotingApp
 * @dev A voting app with an owner that can create a voting session
 */
contract VotingApp is Ownable {
    struct VotingSession {
        string question;
        uint256 yesVotes;
        uint256 noVotes;
        bool active;
        mapping(address => bool) hasVoted;
    }

    mapping(uint256 => VotingSession) public votingSessions;
    uint256 public currentSessionId;

    event NewVotingSession(uint256 indexed sessionId, string question);

    /**
     * @dev Creates a new voting session with the given question
     * @param question The question to be voted on
     */
    function createVotingSession(string memory question) public onlyOwner {
        currentSessionId++;
        votingSessions[currentSessionId].question = question;
        votingSessions[currentSessionId].active = true;
        emit NewVotingSession(currentSessionId, question);
    }

    /**
     * @dev Casts a vote for the current voting session
     * @param vote True for yes, false for no
     */
    function vote(bool vote) public {
        require(votingSessions[currentSessionId].active, "Voting session is not active");
        require(!votingSessions[currentSessionId].hasVoted[msg.sender], "Already voted");

        if (vote) {
            votingSessions[currentSessionId].yesVotes++;
        } else {
            votingSessions[currentSessionId].noVotes++;
        }

        votingSessions[currentSessionId].hasVoted[msg.sender] = true;
    }

    /**
     * @dev Gets the results of the current voting session
     * @return yesVotes The number of yes votes
     * @return noVotes The number of no votes
     */
    function getResults() public view returns (uint256 yesVotes, uint256 noVotes) {
        require(!votingSessions[currentSessionId].active, "Voting session is still active");

        yesVotes = votingSessions[currentSessionId].yesVotes;
        noVotes = votingSessions[currentSessionId].noVotes;
    }
}