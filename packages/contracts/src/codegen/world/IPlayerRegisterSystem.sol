// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { ZKProof } from "./../../libraries/LibSeismic.sol";

/**
 * @title IPlayerRegisterSystem
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IPlayerRegisterSystem {
  function register(bytes32 matchEntity, uint256 spawnIndex, bytes32 heroChoice) external returns (bytes32);

  function registerFOW(
    bytes32 matchEntity,
    uint256 spawnIndex,
    bytes32 heroChoice,
    ZKProof calldata proof,
    uint256[8] calldata pubSignals
  ) external returns (bytes32);
}
