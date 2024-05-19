// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint256 id;
        uint256 voteCount;
        string name;
        string deskripsi;
    }

    uint256 public candidatesCount;
    address public owner;

    mapping(uint256 => Candidate) public candidates;
    mapping(address => bool) public votedOrNot;

    event CandidateAdded(uint256 indexed id, string name);
    event VoteCast(address indexed voter, uint256 indexed candidateId);

    constructor() payable {
        owner = msg.sender;
        addCandidate("Aldi", "Some description about the candidate");
        addCandidate("Taher", "Some description about the candidate");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }

    modifier notOwner() {
        require(msg.sender != owner, "Owner cannot vote");
        _;
    }

    function addCandidate(string memory name, string memory deskripsi) public onlyOwner {
        uint256 newCandidateId = candidatesCount + 1;
        candidatesCount = newCandidateId;
        candidates[newCandidateId] = Candidate(
            newCandidateId,
            0,
            name,
            deskripsi
        );

        emit CandidateAdded(newCandidateId, name);
    }

 function vote(uint256 _candidateId) external notOwner {
        // Memindahkan status votedOrNot[msg.sender] ke dalam variabel lokal
        bool hasVoted = votedOrNot[msg.sender];
        
        require(!hasVoted, "You have already voted");
        require(_candidateId > 0, "Invalid candidate ID: must be greater than 0");
        require(_candidateId <= candidatesCount, "Invalid candidate ID: exceeds candidates count");

        // Mengupdate status pemilih dalam variabel state
        votedOrNot[msg.sender] = true;

        // Mengakses kandidat dalam variabel lokal untuk mengurangi SLOAD
        Candidate storage candidate = candidates[_candidateId];
        candidate.voteCount++;

        emit VoteCast(msg.sender, _candidateId);
    }

    function getCandidate(uint256 _candidateId) public view returns (Candidate memory) {
        require(_candidateId > 0, "Invalid Candidate Id: must be greater than 0");
        require(_candidateId <= candidatesCount, "Invalid Candidate Id: exceeds candidates count");
        return candidates[_candidateId];
    }
    
    function getCandidateById(uint256 _candidateId) public view returns (string memory, string memory, uint256) {
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate ID");
        Candidate memory candidate = candidates[_candidateId];
        return (candidate.name, candidate.deskripsi, candidate.voteCount);
    }
}
