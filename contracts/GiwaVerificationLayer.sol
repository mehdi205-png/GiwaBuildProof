// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract GiwaVerificationLayer {
    struct Verification {
        uint256 id;
        uint256 projectId;
        uint256 versionId;
        bytes32 artifactHash;
        address verifier;
        bool passed;
        string note;
        uint256 createdAt;
    }

    uint256 public nextVerificationId = 1;

    mapping(uint256 => Verification[]) private projectVerifications;

    event VerificationRecorded(
        uint256 indexed projectId,
        uint256 indexed versionId,
        uint256 indexed verificationId,
        bytes32 artifactHash,
        address verifier,
        bool passed,
        string note
    );

    function recordVerification(
        uint256 projectId,
        uint256 versionId,
        bytes32 artifactHash,
        bool passed,
        string calldata note
    ) external returns (uint256 verificationId) {
        verification
