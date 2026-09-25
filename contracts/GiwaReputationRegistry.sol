// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaReputationRegistry {
    struct Reputation {
        uint256 id;
        address contributor;
        uint256 projectId;
        uint256 score;
        string reason;
        uint256 createdAt;
    }

    uint256 public nextReputationId = 1;

    mapping(address => Reputation[]) private reputations;

    event ReputationRecorded(
        uint256 indexed reputationId,
        address indexed contributor,
        uint256 indexed projectId,
        uint256 score,
        string reason
    );

    function recordReputation(
        address contributor,
        uint256 projectId,
        uint256 score,
        string calldata reason
    ) external returns (uint256 reputationId) {
        require(contributor != address(0), "Invalid contributor");
        require(score <= 100, "Score too high");

        reputationId = nextReputationId++;

        reputations[contributor].push(
            Reputation({
                id: reputationId,
                contributor: contributor,
                projectId: projectId,
                score: score,
                reason: reason,
                createdAt: block.timestamp
            })
        );

        emit ReputationRecorded(
            reputationId,
            contributor,
            projectId,
            score,
            reason
        );
    }

    function getReputation(
        address contributor,
        uint256 index
    ) external view returns (Reputation memory) {
        return reputations[contributor][index];
    }

    function reputationCount(
        address contributor
    ) external view returns (uint256) {
        return reputations[contributor].length;
    }
}
