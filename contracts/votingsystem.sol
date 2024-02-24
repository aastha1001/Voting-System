// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting{

    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    mapping (uint => Candidate) public getcandidates;

    struct Voter {
        bool hasVoted;
        uint256 voteChoice;
    }

    mapping(address => Voter) public voters;

    //mapping (address => bool) public hasVoted;

    uint public candidateCount;

    constructor (string[] memory _candidateName) {
        candidateCount = 0;
        for (uint i=0; i<_candidateName.length; i++){
            addCandidate (_candidateName[i]);
        }
    }

    function addCandidate (string memory name) private{
        candidateCount++;
        getcandidates[candidateCount] = Candidate(candidateCount, name, 0);
    }

    function vote (uint _candidateID) public{
        require (_candidateID>0 && _candidateID<=candidateCount, "Invalid ID");
        require (!voters[msg.sender].hasVoted, "Already voted");
        voters[msg.sender] = Voter({hasVoted: true, voteChoice: _candidateID});
        getcandidates[_candidateID].voteCount++;
    }
    
    function getVoteCount (uint _candidateID) public view returns(uint){
        require (_candidateID>0 && _candidateID<=candidateCount, "Invalid Candidate ID");
        return getcandidates[_candidateID].voteCount;
    }
}