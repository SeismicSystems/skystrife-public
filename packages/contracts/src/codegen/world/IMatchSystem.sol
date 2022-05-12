// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

/**
 * @title IMatchSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IMatchSystem {
  function createMatch(
    string memory name,
    bytes32 claimedFirstMatchInWindow,
    bytes32 matchEntity,
    bytes32 levelId
  ) external;

  function createMatchSeasonPass(
    string memory name,
    bytes32 claimedFirstMatchInWindow,
    bytes32 matchEntity,
    bytes32 levelId,
    ResourceId systemId,
    uint256 entranceFee,
    uint256[] memory rewardPercentages
  ) external;

  function createMatchSkyKey(
    string memory name,
    bytes32 claimedFirstMatchInWindow,
    bytes32 matchEntity,
    bytes32 levelId,
    ResourceId systemId,
    uint256 entranceFee,
    uint256[] memory rewardPercentages,
    uint256 registrationTime
  ) external;

  function adminDestroyMatch(bytes32 matchEntity) external;
}
