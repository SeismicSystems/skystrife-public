// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.24;

import { SeismicConfig } from "../codegen/index.sol";

struct ZKProof {
  uint256[2] a;
  uint256[2][2] b;
  uint256[2] c;
}

struct SpawnInputs {
  int32 x;
  int32 y;
  bytes32 matchEntity;
  bytes32 heroChoice;
  uint256 hBlind;
  uint256 hVirtual;
  uint256 hSpawn;
}

interface ISeismicContract {
    function spawn(ZKProof calldata proof, uint256[8] calldata publicSignals) external view returns (bool);
}

function callSeismicSpawn(SpawnInputs calldata inputs, ZKProof calldata proof) {
    address seismicContractAddress = SeismicConfig.getSeismicContract();
    ISeismicContract seismicContract = ISeismicContract(seismicContractAddress);

    uint256 x = 0;
    uint256 signX = 0;
    if (inputs.x < 0) {
      x = uint256(int256(-inputs.x));
      signX = 1;
    } else {
      x = uint256(int256(inputs.x));
    }

    uint256 y = 0;
    uint256 signY = 0;
    if (inputs.y < 0) {
      y = uint256(int256(-inputs.y));
      signY = 1;
    } else {
      y = uint256(int256(inputs.y));
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
