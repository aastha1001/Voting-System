// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping (uint => Candidate) public candidates;

    mapping (address => bool) public hasVoted;

    uint public candidateCount;

    constructor (string[] memory _candidateName) {
        candidateCount = 0;
        for (uint i=0; i<_candidateName.length; i++){
            addCandidate (_candidateName[i]);
        }
    }

    function addCandidate (string memory name) private{
        candidateCount++;
        candidates[candidateCount] = Candidate(candidateCount, name, 0);
    }

    function vote (uint _candidateID) view public{
        require (_candidateID>0 && _candidateID<=candidateCount, "Invalid ID");
    }
}