// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title PremintedNFT
 * @dev ERC721 token contract that mints one token to the deployer address upon deployment.
 */
contract PremintedNFT is ERC721, Ownable {
    constructor() ERC721("PremintedNFT", "PMNFT") {
        _mint(msg.sender, 1);
    }
}

/**
 * @title VotingApp
 * @dev A smart contract that allows the owner to create a voting session and have signatures for voting.
 */
contract VotingApp is Ownable {
    struct VotingSession {
        string question;
        uint256 startTime;
        uint256 endTime;
        mapping(address => bool) hasVoted;
        mapping(bytes32 => uint256) votes;
    }

    mapping(bytes32 => VotingSession) public votingSessions;

    event VotingSessionCreated(bytes32 indexed sessionId, string question, uint256 startTime, uint256 endTime);
    event VoteCast(bytes32 indexed sessionId, address indexed voter, uint256 vote);

    /**
     * @dev Creates a new voting session.
     * @param sessionId The unique identifier for the voting session.
     * @param question The question being asked in the voting session.
     * @param startTime The start time of the voting session.
     * @param endTime The end time of the voting session.
     */
    function createVotingSession(bytes32 sessionId, string memory question, uint256 startTime, uint256 endTime) public onlyOwner {
        require(startTime < endTime, "Invalid voting session times");
        require(votingSessions[sessionId].startTime == 0, "Voting session already exists");

        votingSessions[sessionId] = VotingSession({
            question: question,
            startTime: startTime,
            endTime: endTime
        });

        emit VotingSessionCreated(sessionId, question, startTime, endTime);
    }

    /**
     * @dev Casts a vote in a voting session.
     * @param sessionId The unique identifier for the voting session.
     * @param vote The vote being cast.
     */
    function castVote(bytes32 sessionId, uint256 vote) public {
        require(votingSessions[sessionId].startTime <= block.timestamp, "Voting session has not started");
        require(votingSessions[sessionId].endTime >= block.timestamp, "Voting session has ended");
        require(!votingSessions[sessionId].hasVoted[msg.sender], "Already voted");

        votingSessions[sessionId].hasVoted[msg.sender] = true;
        votingSessions[sessionId].votes[keccak256(abi.encodePacked(msg.sender, vote))]++;

        emit VoteCast(sessionId, msg.sender, vote);
    }
}