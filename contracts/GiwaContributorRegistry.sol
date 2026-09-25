// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaContributorRegistry {
    struct Contributor {
        address account;
        string name;
        string role;
        uint256 joinedAt;
        bool active;
    }

    struct Contribution {
        uint256 id;
        address contributor;
        uint256 projectId;
        string contributionType;
        string uri;
        uint256 timestamp;
    }

    uint256 public nextContributorId = 1;
    uint256 public nextContributionId = 1;

    mapping(uint256 => Contributor) public contributors;
    mapping(address => uint256) public contributorOf;
    mapping(uint256 => Contribution[]) private contributions;

    event ContributorRegistered(
        uint256 indexed contributorId,
        address indexed account,
        string name,
        string role
    );

    event ContributionRecorded(
        uint256 indexed contributionId,
        uint256 indexed projectId,
        address indexed contributor,
        string contributionType,
        string uri
    );

    function registerContributor(
        string calldata name,
        string calldata role
    ) external returns (uint256 contributorId) {
        require(contributorOf[msg.sender] == 0, "Already registered");

        contributorId = nextContributorId++;

        contributors[contributorId] = Contributor({
            account: msg.sender,
            name: name,
            role: role,
            joinedAt: block.timestamp,
            active: true
        });

        contributorOf[msg.sender] = contributorId;

        emit ContributorRegistered(
            contributorId,
            msg.sender,
            name,
            role
        );
    }

    function recordContribution(
        uint256 projectId,
        string calldata contributionType,
        string calldata uri
    ) external returns (uint256 contributionId) {
        uint256 contributorId = contributorOf[msg.sender];
        require(contributorId != 0, "Not registered");
        require(contributors[contributorId].active, "Contributor inactive");

        contributionId = nextContributionId++;

        contributions[projectId].push(
            Contribution({
                id: contributionId,
                contributor: msg.sender,
                projectId: projectId,
                contributionType: contributionType,
                uri: uri,
                timestamp: block.timestamp
            })
        );

        emit ContributionRecorded(
            contributionId,
            projectId,
            msg.sender,
            contributionType,
            uri
        );
    }

    function getContribution(
        uint256 projectId,
        uint256 index
    ) external view returns (Contribution memory) {
        return contributions[projectId][index];
    }

    function contributionCount(
        uint256 projectId
    ) external view returns (uint256) {
        return contributions[projectId].length;
    }
}
