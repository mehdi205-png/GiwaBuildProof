# Mergit Pay-on-Merge

This document records the Mergit integration for GiwaBuildProof.

## Purpose

The integration connects a GitHub issue and pull request to an on-chain Mergit bounty.

## Bounty

The current integration test uses Mergit Bounty #6 on GIWA Sepolia.

## Workflow

1. A GitHub Issue defines the requested work.
2. The bounty is funded on GIWA Sepolia.
3. The pull request references the bounty.
4. CI is completed successfully.
5. The pull request is merged.
6. Mergit verifies the merge and settles the bounty on-chain.

## Repository

https://github.com/mehdi205-png/GiwaBuildProof
