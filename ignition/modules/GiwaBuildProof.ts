import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const GiwaBuildProofModule = buildModule("GiwaBuildProofModule", (m) => {
  const giwaBuildProof = m.contract("GiwaBuildProof");

  return {
    giwaBuildProof,
  };
});

export default GiwaBuildProofModule;