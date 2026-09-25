// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaAttestationRegistry {
    struct Attestation {
        uint256 id;
        uint256 projectId;
        uint256 versionId;
        address attester;
        bytes32 artifactHash;
        bool passed;
        string attestationType;
        string note;
        uint256 createdAt;
    }

    uint256 public nextAttestationId = 1;

    mapping(uint256 => Attestation[]) private projectAttestations;

    event AttestationRecorded(
        uint256 indexed attestationId,
        uint256 indexed projectId,
        uint256 indexed versionId,
        address attester,
        bytes32 artifactHash,
        bool passed,
        string attestationType,
        string note
    );

    function recordAttestation(
        uint256 projectId,
        uint256 versionId,
        bytes32 artifactHash,
        bool passed,
        string calldata attestationType,
        string calldata note
    ) external returns (uint256 attestationId) {
        attestationId = nextAttestationId++;

        projectAttestations[projectId].push(
            Attestation({
                id: attestationId,
                projectId: projectId,
                versionId: versionId,
                attester: msg.sender,
                artifactHash: artifactHash,
                passed: passed,
                attestationType: attestationType,
                note: note,
                createdAt: block.timestamp
            })
        );

        emit AttestationRecorded(
            projectId,
            versionId,
            attestationId,
            msg.sender,
            artifactHash,
            passed,
            attestationType,
            note
        );
    }

    function getAttestation(
        uint256 projectId,
        uint256 index
    ) external view returns (Attestation memory) {
        return projectAttestations[projectId][index];
    }

    function attestationCount(
        uint256 projectId
    ) external view returns (uint256) {
        return projectAttestations[projectId].length;
    }
}
