// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is Ownable {
    
    constructor() Ownable(msg.sender) {}

        // ---- Structures de données ----
        struct Voter {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
        }

        struct Proposal {
        string description;
        uint voteCount;
        }

    // ---- Enumération pour le statut du workflow ----
    enum WorkflowStatus {
        RegisteringVoters,
        ProposalsRegistrationStarted,
        ProposalsRegistrationEnded,
        VotingSessionStarted,
        VotingSessionEnded,
        VotesTallied

    }

    // ---- Variables d'état ----
    WorkflowStatus public currentStatus;
    uint public winningProposalId;

    // ---- Mappings et tableaux ----
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    
    // ---- Événements ----
    event VoterRegistered(address voterAddress);
    event WorkflowStatusChange(WorkflowStatus previousStatus, WorkflowStatus newStatus);
    event ProposalRegistered(uint proposalId);
    event Voted(address voter, uint proposalId);

    // ---- Modificateurs ----
    modifier onlyRegistered() {
        require(voters[msg.sender].isRegistered, "Vous netes pas enregistre.");
        _;
    }

    modifier inStatus(WorkflowStatus _status) {
        require(currentStatus == _status, "Mauvais statut du workflow.");
        _;
    }

    // ---- Fonctions administratives ----

    /// @notice Enregistre un électeur dans la whitelist
    function registerVoter(address _voter) external onlyOwner inStatus(WorkflowStatus.RegisteringVoters) {
        require(!voters[_voter].isRegistered, "Electeur sur liste.");
        voters[_voter].isRegistered = true;
        emit VoterRegistered(_voter);
    }

    /// @notice Démarre la session d'enregistrement des propositions
    function startProposalsRegistration() external onlyOwner inStatus(WorkflowStatus.RegisteringVoters) {
        currentStatus = WorkflowStatus.ProposalsRegistrationStarted;
        emit WorkflowStatusChange(WorkflowStatus.RegisteringVoters, currentStatus);
    }

    /// @notice Met fin à la session d'enregistrement des propositions
    function endProposalsRegistration() external onlyOwner inStatus(WorkflowStatus.ProposalsRegistrationStarted) {
        currentStatus = WorkflowStatus.ProposalsRegistrationEnded;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationStarted, currentStatus);
    }

    /// @notice Démarre la session de vote
    function startVotingSession() external onlyOwner inStatus(WorkflowStatus.ProposalsRegistrationEnded) {
        currentStatus = WorkflowStatus.VotingSessionStarted;
        emit WorkflowStatusChange(WorkflowStatus.ProposalsRegistrationEnded, currentStatus);
    }

    /// @notice Met fin à la session de vote
    function endVotingSession() external onlyOwner inStatus(WorkflowStatus.VotingSessionStarted) {
        currentStatus = WorkflowStatus.VotingSessionEnded;
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionStarted, currentStatus);
    }

    /// @notice Comptabilise les votes et détermine le gagnant
    function tallyVotes() external onlyOwner inStatus(WorkflowStatus.VotingSessionEnded) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > winningVoteCount) {
                winningVoteCount = proposals[i].voteCount;
                winningProposalId = i;
            }
        }
        currentStatus = WorkflowStatus.VotesTallied;
        emit WorkflowStatusChange(WorkflowStatus.VotingSessionEnded, currentStatus);
    }

    // ---- Fonctions électeurs ----

    /// @notice Les électeurs enregistrés peuvent soumettre des propositions
    function submitProposal(string calldata _description) external onlyRegistered inStatus(WorkflowStatus.ProposalsRegistrationStarted) {
        proposals.push(Proposal(_description, 0));
        emit ProposalRegistered(proposals.length - 1);
    }

    /// @notice Vote pour une proposition
    function vote(uint _proposalId) external onlyRegistered inStatus(WorkflowStatus.VotingSessionStarted) {
        require(!voters[msg.sender].hasVoted, "Vous avez deja vote.");
        require(_proposalId < proposals.length, "Proposition inexistante.");

        voters[msg.sender].hasVoted = true;
        voters[msg.sender].votedProposalId = _proposalId;
        proposals[_proposalId].voteCount++;

        emit Voted(msg.sender, _proposalId);
    }

    /// @notice Récupère la proposition gagnante
    function getWinner() external view returns (string memory description, uint voteCount) {
        require(currentStatus == WorkflowStatus.VotesTallied, "Les votes n'ont pas ete comptabilises.");
        Proposal memory winningProposal = proposals[winningProposalId];
        return (winningProposal.description, winningProposal.voteCount);
    }
}
