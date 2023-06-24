// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title JavaCoin
 * @dev This contract allows for the minting and burning of JavaCoin tokens.
 */
contract JavaCoin is Ownable {
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply;

    /**
     * @dev Emitted when `value` tokens are minted for `to`.
     */
    event Mint(address indexed to, uint256 value);

    /**
     * @dev Emitted when `value` tokens are burned from `from`.
     */
    event Burn(address indexed from, uint256 value);

    /**
     * @dev Returns the total supply of JavaCoin tokens.
     */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the balance of the specified address.
     * @param account The address to query the balance of.
     */
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev Mint `amount` of JavaCoin tokens and transfer them to `to`.
     * @param to The address to receive the minted tokens.
     * @param amount The amount of tokens to mint.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "JavaCoin: mint to the zero address");
        _totalSupply += amount;
        _balances[to] += amount;
        emit Mint(to, amount);
    }

    /**
     * @dev Burn `amount` of JavaCoin tokens from `from`.
     * @param from The address to burn the tokens from.
     * @param amount The amount of tokens to burn.
     */
    function burn(address from, uint256 amount) public onlyOwner {
        require(from != address(0), "JavaCoin: burn from the zero address");
        require(_balances[from] >= amount, "JavaCoin: insufficient balance");
        _totalSupply -= amount;
        _balances[from] -= amount;
        emit Burn(from, amount);
    }
}

/**
 * @title VotingApp
 * @dev This contract allows the owner to create a voting session and for users to vote on proposals.
 */
contract VotingApp is Ownable {
    struct Proposal {
        string description;
        uint256 voteCount;
        mapping(address => bool) votes;
    }

    mapping(uint256 => Proposal) private _proposals;
    uint256 private _proposalCount;

    /**
     * @dev Emitted when a new proposal is created.
     */
    event ProposalCreated(uint256 indexed proposalId, string description);

    /**
     * @dev Emitted when a user votes on a proposal.
     */
    event Vote(uint256 indexed proposalId, address indexed voter);

    /**
     * @dev Creates a new proposal with the given `description`.
     * @param description The description of the proposal.
     */
    function createProposal(string memory description) public onlyOwner {
        _proposalCount++;
        _proposals[_proposalCount].description = description;
        emit ProposalCreated(_proposalCount, description);
    }

    /**
     * @dev Returns the description of the proposal with the given `proposalId`.
     * @param proposalId The ID of the proposal.
     */
    function getProposalDescription(uint256 proposalId) public view returns (string memory) {
        return _proposals[proposalId].description;
    }

    /**
     * @dev Returns the vote count of the proposal with the given `proposalId`.
     * @param proposalId The ID of the proposal.
     */
    function getProposalVoteCount(uint256 proposalId) public view returns (uint256) {
        return _proposals[proposalId].voteCount;
    }

    /**
     * @dev Allows a user to vote on the proposal with the given `proposalId`.
     * @param proposalId The ID of the proposal.
     */
    function vote(uint256 proposalId) public {
        require(keccak256(bytes(_proposals[proposalId].description)) != keccak256(""), "VotingApp: invalid proposal ID");

        require(!_proposals[proposalId].votes[msg.sender], "VotingApp: already voted");
        _proposals[proposalId].votes[msg.sender] = true;
        _proposals[proposalId].voteCount++;
        emit Vote(proposalId, msg.sender);
    }
}