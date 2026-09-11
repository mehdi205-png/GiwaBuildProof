// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaBuildProof {
    struct Project {
        address owner;
        string name;
        string repo;
        uint64 createdAt;
        bool exists;
    }

    struct Milestone {
        bytes32 artifactHash;
        string uri;
        uint64 recordedAt;
    }

    uint256 public nextProjectId;

    mapping(uint256 => Project) public projects;
    mapping(uint256 => Milestone[]) private milestones;

    event ProjectRegistered(
        uint256 indexed projectId,
        address indexed owner,
        string name,
        string repo
    );

    event MilestoneRecorded(
        uint256 indexed projectId,
        uint256 indexed milestoneId,
        bytes32 artifactHash,
        string uri
    );

    modifier onlyProjectOwner(uint256 projectId) {
        require(projects[projectId].exists, "project does not exist");
        require(
            projects[projectId].owner == msg.sender,
            "not project owner"
        );
        _;
    }

    function registerProject(
        string calldata name,
        string calldata repo
    ) external returns (uint256 projectId) {
        require(bytes(name).length > 0, "name required");

        projectId = ++nextProjectId;

        projects[projectId] = Project({
            owner: msg.sender,
            name: name,
            repo: repo,
            createdAt: uint64(block.timestamp),
            exists: true
        });

        emit ProjectRegistered(
            projectId,
            msg.sender,
            name,
            repo
        );
    }

    function recordMilestone(
        uint256 projectId,
        bytes32 artifactHash,
        string calldata uri
    )
        external
        onlyProjectOwner(projectId)
        returns (uint256 milestoneId)
    {
        milestoneId = milestones[projectId].length;

        milestones[projectId].push(
            Milestone({
                artifactHash: artifactHash,
                uri: uri,
                recordedAt: uint64(block.timestamp)
            })
        );

        emit MilestoneRecorded(
            projectId,
            milestoneId,
            artifactHash,
            uri
        );
    }

    function milestoneCount(
        uint256 projectId
    ) external view returns (uint256) {
        return milestones[projectId].length;
    }

    function getMilestone(
        uint256 projectId,
        uint256 milestoneId
    ) external view returns (Milestone memory) {
        require(
            milestoneId < milestones[projectId].length,
            "milestone does not exist"
        );

        return milestones[projectId][milestoneId];
    }

    function getMilestones(
        uint256 projectId
    ) external view returns (Milestone[] memory) {
        return milestones[projectId];
    }
}