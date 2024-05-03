// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.24;

import { SeismicConfig } from "../codegen/index.sol";

struct ZKProof {
  uint256[2] a;
  uint256[2][2] b;
  uint256[2] c;
}

interface ISeismicContract {
    function spawn(ZKProof calldata proof, uint256[5] calldata pubSignals) external view returns (bool);
}

function callSeismicSpawn(ZKProof calldata proof, uint256[5] calldata pubSignals) {
    address seismicContractAddress = SeismicConfig.getSeismicContract();
    ISeismicContract seismicContract = ISeismicContract(seismicContractAddress);

    seismicContract.spawn(proof, pubSignals);
}
