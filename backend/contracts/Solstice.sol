// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Solstice {
    struct Candidate {
        string name;
        uint256 voteCount;
    }

    address public owner;
    uint256 public solsticeID;

    mapping(uint256 => mapping(address => bool)) public voters;
    mapping(uint256 => Candidate[]) public solsticeCandidates;
    mapping(uint256 => uint256) public votingStart;
    mapping(uint256 => uint256) public votingEnd;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function.");
        _;
    }

    function addCandidate(
        uint256 _solsticeID,
        string memory _name
    ) public onlyOwner {
        solsticeCandidates[_solsticeID].push(
            Candidate({name: _name, voteCount: 0})
        );
    }

    function vote(uint256 _solsticeID, uint256 _candidateIndex) public {
        require(!voters[_solsticeID][msg.sender], "You have already voted.");
        require(
            _candidateIndex < solsticeCandidates[_solsticeID].length,
            "Invalid candidate index."
        );

        solsticeCandidates[_solsticeID][_candidateIndex].voteCount++;
        voters[_solsticeID][msg.sender] = true;
    }

    function getAllVotesOfCandidates(
        uint256 _solsticeID
    ) public view returns (Candidate[] memory) {
        return solsticeCandidates[_solsticeID];
    }

    function getVotingStatus(uint256 _solsticeID) public view returns (bool) {
        return (block.timestamp >= votingStart[_solsticeID] &&
            block.timestamp < votingEnd[_solsticeID]);
    }

    function getRemainingTime(
        uint256 _solsticeID
    ) public view returns (uint256) {
        require(
            block.timestamp >= votingStart[_solsticeID],
            "Voting has not started yet."
        );
        if (block.timestamp >= votingEnd[_solsticeID]) {
            return 0;
        }
        return votingEnd[_solsticeID] - block.timestamp;
    }

    function startSolstice(
        uint256 _durationInMinutes,
        string[] memory _candidateNames
    ) public {
        solsticeID += 1;
        for (uint256 i = 0; i < _candidateNames.length; i++) {
            solsticeCandidates[solsticeID].push(
                Candidate({name: _candidateNames[i], voteCount: 0})
            );
        }

        votingStart[solsticeID] = block.timestamp;
        votingEnd[solsticeID] =
            block.timestamp +
            (_durationInMinutes * 1 minutes);
    }
}
