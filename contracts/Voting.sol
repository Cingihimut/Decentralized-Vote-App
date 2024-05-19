//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint256 id;
        string name;
        string deskripsi;
        uint256 voteCount;
    }

    uint256 candidatesCount;
    address owner;

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public votedOrNot;

    event CandidateAdded(uint256 indexed id, string name);
    event VoteCast(address indexed voter, uint256 indexed candidateId);

    constructor() {
        owner = msg.sender;
        addCandidate("Aldi", "Some description about the candidate");
        addCandidate("Taher", "Some description about the candidate");
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only contract owner can perform this action"
        );
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot  vote");
        _;
    }

    function addCandidate(
        string memory name,
        string memory deskripsi
    ) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(
            candidatesCount,
            name,
            deskripsi,
            0
        );

        emit CandidateAdded(candidatesCount, name);
    }

    function vote(uint256 _candidateId) public {
        require(!votedOrNot[msg.sender], "You have already voted");
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate ID"
        );

        candidates[_candidateId].voteCount++;

        votedOrNot[msg.sender] = true;

        emit VoteCast(msg.sender, _candidateId);
    }

    function getCandidate(
        uint256 _candidateId
    ) public view returns (uint256, string memory, string memory, uint256) {
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid Candidate Id"
        );
        Candidate memory candidate = candidates[_candidateId];
        return (
            candidate.id,
            candidate.name,
            candidate.deskripsi,
            candidate.voteCount
        );
    }

    function getCandidateById(
        uint256 _candidateId
    ) public view returns (string memory, string memory, uint256) {
        require(
            _candidateId > 0 && _candidateId <= candidatesCount,
            "Invalid candidate ID"
        );
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.deskripsi, candidate.voteCount);
    }
}
