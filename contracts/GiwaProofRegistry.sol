// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaProofRegistry {
    struct Project {
        uint256 id;
        address owner;
        string name;
        string repo;
        uint256 createdAt;
        bool active;
    }

    struct Version {
        uint256 id;
        uint256 projectId;
        string version;
        bytes32 artifactHash;
        string uri;
        uint256 createdAt;
    }

    struct Milestone {
        uint256 id;
        uint256 projectId;
        bytes32 artifactHash;
        string uri;
        uint256 createdAt;
    }

    uint256 public nextProjectId = 1;
    uint256 public nextVersionId = 1;
    uint256 public nextMilestoneId = 1;

    mapping(uint256 => Project) public projects;
    mapping(uint256 => Version[]) private projectVersions;
    mapping(uint256 => Milestone[]) private projectMilestones;

    event ProjectRegistered(
        uint256 indexed projectId,
        address indexed owner,
        string name,
        string repo
    );

    event VersionAdded(
        uint256 indexed projectId,
        uint256 indexed versionId,
        string version,
        bytes32 artifactHash,
        string uri
    );

    event MilestoneRecorded(
        uint256 indexed projectId,
        uint256 indexed milestoneId,
        bytes32 artifactHash,
        string uri
    );

    modifier onlyProjectOwner(uint256 projectId) {
        require(projects[projectId].owner == msg.sender, "Not project owner");
        _;
    }

    function registerProject(
        string calldata name,
        string calldata repo
    ) external returns (uint256 projectId) {
        projectId = nextProjectId++;

        projects[projectId] = Project({
            id: projectId,
            owner: msg.sender,
            name: name,
            repo: repo,
            createdAt: block.timestamp,
            active: true
        });

        emit ProjectRegistered(
            projectId,
            msg.sender,
            name,
            repo
        );
    }

    function addVersion(
        uint256 projectId,
        string calldata version,
        bytes32 artifactHash,
        string calldata uri
    ) external onlyProjectOwner(projectId) returns (uint256 versionId) {
        require(projects[projectId].active, "Project inactive");

        versionId = nextVersionId++;

        projectVersions[projectId].push(
            Version({
                id: versionId,
                projectId: projectId,
                version: version,
                artifactHash: artifactHash,
                uri: uri,
                createdAt: block.timestamp
            })
        );

        emit VersionAdded(
            projectId,
            versionId,
            version,
            artifactHash,
            uri
        );
    }

    function recordMilestone(
        uint256 projectId,
        bytes32 artifactHash,
        string calldata uri
    ) external onlyProjectOwner(projectId) returns (uint256 milestoneId) {
        require(projects[projectId].active, "Project inactive");

        milestoneId = nextMilestoneId++;

        projectMilestones[projectId].push(
            Milestone({
                id: milestoneId,
                projectId: projectId,
                artifactHash: artifactHash,
                uri: uri,
                createdAt: block.timestamp
            })
        );
    }

    function getVersion(
        uint256 projectId,
        uint256 index
    ) external view returns (Version memory) {
        return projectVersions[projectId][index];
    }

    function getMilestone(
        uint256 projectId,
        uint256 index
    ) external view returns (Milestone memory) {
        return projectMilestones[projectId][index];
    }

    function versionCount(
        uint256 projectId
    ) external view returns (uint256) {
        return projectVersions[projectId].length;
    }

    function milestoneCount(
        uint256 projectId
    ) external view returns (uint256) {
        return projectMilestones[projectId].length;
    }
}
