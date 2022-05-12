// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

/**
 * @title IAllowListSystem
 * @dev This interface is automatically generated from the corresponding system contract. Do not edit manually.
 */
interface IAllowListSystem {
  function isAllowed(bytes32 matchEntity, address account) external view returns (bool);

  function setMembers(bytes32 matchEntity, address[] memory accounts) external;
}
