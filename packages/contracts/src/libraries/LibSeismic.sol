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
  uint256 spawnIndex;
}

interface ISeismicContract {
    function spawn(ZKProof calldata proof, uint256[8] calldata publicSignals) external view returns (bool);
}

function callSeismicSpawn(SpawnInputs calldata inputs, ZKProof calldata proof, bytes32 levelId) {
    address seismicContractAddress = SeismicConfig.getSeismicContract();
    ISeismicContract seismicContract = ISeismicContract(seismicContractAddress);

    LevelPositionData memory spawn = LevelPosition.get(levelId, inputs.spawnIndex);

    uint256 x = 0;
    uint256 signX = 0;
    if (spawn.x < 0) {
      x = uint256(int256(-spawn.x));
      signX = 1;
    } else {
      x = uint256(int256(spawn.x));
    }

    uint256 y = 0;
    uint256 signY = 0;
    if (spawn.y < 0) {
      y = uint256(int256(-spawn.y));
      signY = 1;
    } else {
      y = uint256(int256(spawn.y));
    }

    uint256[8] memory publicSignals = [
      inputs.hBlind,
      inputs.hVirtual,
      inputs.hSpawn,
      x,
      signX,
      y,
      signY,
      uint256(inputs.heroChoice)
    ];

    seismicContract.spawn(proof, publicSignals);
}
