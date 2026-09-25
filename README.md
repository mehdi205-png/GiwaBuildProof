# GiwaBuildProof

A technical on-chain proof and verification project deployed on **GIWA Sepolia**.

The project demonstrates a progression of smart-contract development for project registration, versioning, verification, contribution tracking, reputation, and attestations.

## Network

- Network: GIWA Sepolia
- Chain ID: 91342
- Explorer: https://sepolia-explorer.giwa.io
- Repository: https://github.com/mehdi205-png/GiwaBuildProof

## Deployed Contracts

| Version | Contract | Address | Purpose |
|---|---|---|---|
| V1 | GiwaBuildProof | `0xd147597dEF40f925Cb69E81dedf233B182f10A5F` | Project registration and milestone proof |
| V2 | GiwaProofRegistry | `0x7AA31d62cB54A754376c148B366860B40081216` | Projects, versions and milestones |
| V3 | GiwaVerificationLayer | `0x236F84D6c6280d4C00EC4F7a94B437a0877F8D4D` | On-chain verification records |
| V4 | GiwaContributorRegistry | `0xE29c1d5A8824F428898f3A0b1276d2717Fa176e6` | Contributor and contribution registry |
| V5 | GiwaReputationRegistry | `0xfdb030576F7eB5A0D1E60D270e562121f8acf46c` | Contributor reputation records |
| V6 | GiwaAttestationRegistry | `0x021a10Dd41be93B83FD4E2738F251Ada43Ebca82` | Technical artifact attestations |

## Development Progression

### V1 — GiwaBuildProof
Basic project registration and milestone recording.

### V2 — GiwaProofRegistry
Extended the system with project versions, milestones and ownership controls.

### V3 — GiwaVerificationLayer
Added on-chain verification records linked to projects and versions.

### V4 — GiwaContributorRegistry
Added contributor registration and contribution tracking.

### V5 — GiwaReputationRegistry
Added reputation records for contributors and projects.

### V6 — GiwaAttestationRegistry
Added technical artifact attestations containing artifact hashes, verification status and notes.

## Mergit Pay-on-Merge

The project also includes a working Mergit integration on GIWA Sepolia.

Workflow:

1. GitHub Issue defines the work.
2. An on-chain Mergit bounty is funded.
3. A pull request references the bounty.
4. GitHub CI verifies the project.
5. The pull request is merged.
6. Mergit verifies the merge and settles the bounty on-chain.

### Completed Mergit Test

- Bounty: #6
- Amount: 0.0005 ETH
- Paid to developer: 0.0004925 ETH
- Network: GIWA Sepolia
- Settlement transaction:

https://sepolia-explorer.giwa.io/tx/0xa60555912e662bc22ef928d8bde7e885316fe47664ea749cd3b1ae14e8f4c279

## Scope

This repository is a technical demonstration of on-chain development and GitHub-integrated verification workflows on GIWA Sepolia.

It is intended as a reproducible development record rather than a production financial application.
