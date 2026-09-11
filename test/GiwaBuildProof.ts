import { network } from "hardhat";
import { describe, it } from "node:test";
import assert from "node:assert/strict";

describe("GiwaBuildProof", async function () {
  const { viem } = await network.connect();

  it("should register a project", async function () {
    const [owner] = await viem.getWalletClients();

    const contract = await viem.deployContract("GiwaBuildProof");

    await contract.write.registerProject([
      "GiwaBuildProof",
      "https://github.com/your-repo/GiwaBuildProof",
    ]);

    const project = await contract.read.projects([1n]);

    assert.equal(project[0].toLowerCase(), owner.account.address.toLowerCase());
    assert.equal(project[1], "GiwaBuildProof");
    assert.equal(project[4], true);
  });

  it("should record a milestone", async function () {
    const contract = await viem.deployContract("GiwaBuildProof");

    await contract.write.registerProject([
      "GiwaBuildProof",
      "https://github.com/your-repo/GiwaBuildProof",
    ]);

    const artifactHash =
      "0x1234567890123456789012345678901234567890123456789012345678901234";

    await contract.write.recordMilestone([
      1n,
      artifactHash,
      "ipfs://example-milestone",
    ]);

    const count = await contract.read.milestoneCount([1n]);

    assert.equal(count, 1n);
  });
});