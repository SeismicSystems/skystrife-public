// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { IAllowListSystem } from "./IAllowListSystem.sol";
import { IBuildSystem } from "./IBuildSystem.sol";
import { ICopyMapSystem } from "./ICopyMapSystem.sol";
import { ICreateSeasonPassSystem } from "./ICreateSeasonPassSystem.sol";
import { IHeroConfigSystem } from "./IHeroConfigSystem.sol";
import { ILevelRotationSystem } from "./ILevelRotationSystem.sol";
import { ILevelUploadSystem } from "./ILevelUploadSystem.sol";
import { ILobbySystem } from "./ILobbySystem.sol";
import { IMatchSystem } from "./IMatchSystem.sol";
import { IMoveSystem } from "./IMoveSystem.sol";
import { INameSystem } from "./INameSystem.sol";
import { IOfficialLevelSystem } from "./IOfficialLevelSystem.sol";
import { IPlayerRegisterSystem } from "./IPlayerRegisterSystem.sol";
import { ISeasonPassSystem } from "./ISeasonPassSystem.sol";
import { ISeismicSystem } from "./ISeismicSystem.sol";
import { ITemplateSpawnSystem } from "./ITemplateSpawnSystem.sol";
import { IWithdrawSystem } from "./IWithdrawSystem.sol";

/**
 * @title IWorld
 * @author MUD (https://mud.dev) by Lattice (https://lattice.xyz)
 * @notice This interface integrates all systems and associated function selectors
 * that are dynamically registered in the World during deployment.
 * @dev This is an autogenerated file; do not edit manually.
 */
interface IWorld is
  IBaseWorld,
  IAllowListSystem,
  IBuildSystem,
  ICopyMapSystem,
  ICreateSeasonPassSystem,
  IHeroConfigSystem,
  ILevelRotationSystem,
  ILevelUploadSystem,
  ILobbySystem,
  IMatchSystem,
  IMoveSystem,
  INameSystem,
  IOfficialLevelSystem,
  IPlayerRegisterSystem,
  ISeasonPassSystem,
  ISeismicSystem,
  ITemplateSpawnSystem,
  IWithdrawSystem
{}
