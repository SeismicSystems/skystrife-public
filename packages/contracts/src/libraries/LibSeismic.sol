// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.24;

import { SeismicConfig } from "../codegen/index.sol";

import { LevelPosition, LevelPositionData } from "../codegen/index.sol";

struct ZKProof {
  uint256[2] a;
  uint256[2][2] b;
  uint256[2] c;
}

struct SpawnInputs {
  bytes32 matchEntity;
  bytes32 heroChoice;
  uint256 hBlind;
  uint256 hVirtual;
  uint256 hSpawn;
  uint256 hSettlement;
  uint256 spawnIndex;
}

struct PlayerActionSignature {
  bytes32 r;
  bytes32 s;
  uint8 v;
}

interface ISeismicContract {
    function spawn(address player, ZKProof calldata proof, uint256[7] calldata publicSignals) external;
}

function getPlayerFromSpawnSig(
  SpawnInputs calldata inputs, 
  PlayerActionSignature calldata sig
) returns (address) {
  bytes32 hash = keccak256(abi.encode("spawn", inputs.matchEntity, inputs.heroChoice, inputs.spawnIndex));
  bytes32 prefixedHash = keccak256(
    abi.encodePacked("\x19Ethereum Signed Message:\n32", hash)
  );
  return ecrecover(prefixedHash, sig.v, sig.r, sig.s);
}

function callSeismicSpawn(address player, SpawnInputs calldata inputs, ZKProof calldata proof) {
    address seismicContractAddress = SeismicConfig.getSeismicContract();
    ISeismicContract seismicContract = ISeismicContract(seismicContractAddress);

    uint256[7] memory publicSignals = [
      inputs.hBlind,
      inputs.hVirtual,
      inputs.hSpawn,
      inputs.hSettlement,
      inputs.spawnIndex,
      uint256(uint128(bytes16(inputs.heroChoice << 128))),
      uint256(uint128(bytes16(inputs.heroChoice)))
    ];

    seismicContract.spawn(player, proof, publicSignals);
}
