// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Candidate {
        string name;
        uint voteCount;
    }

    address public owner;
    bool public votingOpen;

    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor(string[] memory _names) {
        owner = msg.sender;
        for (uint i = 0; i < _names.length; i++) {
            candidates.push(Candidate({ name: _names[i], voteCount: 0 }));
        }
        votingOpen = true;
    }

    function vote(uint candidateIndex) public {
        require(votingOpen, "Voting is closed.");
        require(!hasVoted[msg.sender], "You already voted.");
        require(candidateIndex < candidates.length, "Invalid candidate.");

        candidates[candidateIndex].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    function endVoting() public {
        require(msg.sender == owner, "Only owner can end voting.");
        votingOpen = false;
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }
}