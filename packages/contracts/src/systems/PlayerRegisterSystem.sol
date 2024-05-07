// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { SystemSwitch } from "@latticexyz/world-modules/src/utils/SystemSwitch.sol";

import { SkyPoolConfig, MatchAccessControl, MatchSweepstake, LevelTemplates, MatchConfig, Player, SpawnPoint, SpawnReservedBy, Position, PositionData, MatchSpawnPoints } from "../codegen/index.sol";
import { MatchAccessControl, LevelTemplates, MatchConfig, Player, SpawnPoint, SpawnReservedBy, Position, PositionData, MatchSpawnPoints, HeroInRotation, HeroInSeasonPassRotation, MatchPlayer, LevelPosition, LevelPositionData } from "../codegen/index.sol";
import { SpawnSettlementTemplateId } from "../codegen/Templates.sol";

import { IAllowSystem } from "../IAllowSystem.sol";
import { transferToken } from "../transferToken.sol";
import { hasSeasonPass } from "../hasToken.sol";

import { LibPlayerSetup } from "base/libraries/LibPlayerSetup.sol";

import { ZKProof, callSeismicSpawn } from "../libraries/LibSeismic.sol";

function checkAccessControl(bytes32 matchEntity, address account) returns (bool) {
  ResourceId systemId = MatchAccessControl.get(matchEntity);
  // If access control is not set, skip the check
  if (ResourceId.unwrap(systemId) == 0) {
    return true;
  }

  bytes memory data = SystemSwitch.call(systemId, abi.encodeCall(IAllowSystem.isAllowed, (matchEntity, account)));

  return abi.decode(data, (bool));
}

contract PlayerRegisterSystem is System {
  // Register msgSender for the given `matchEntity`
  function register(
    bytes32 matchEntity, 
    uint256 spawnIndex, 
    bytes32 heroChoice
  ) public returns (bytes32) {
    require(checkAccessControl(matchEntity, _msgSender()), "caller is not allowed");
    require(SpawnReservedBy.get(matchEntity, spawnIndex) == 0, "spawn point already reserved");
    require(MatchPlayer.get(matchEntity, _msgSender()) == 0, "this account has already registered for the match");

    bool inRotation = HeroInRotation.get(heroChoice);
    require(
      inRotation || (hasSeasonPass(_msgSender()) && HeroInSeasonPassRotation.get(heroChoice)),
      "invalid hero choice"
    );

    bytes32 levelId = MatchConfig.getLevelId(matchEntity);
    require(LevelTemplates.getItem(levelId, spawnIndex) == SpawnSettlementTemplateId, "level entity is not a spawn");

    uint256 registrationTime = MatchConfig.getRegistrationTime(matchEntity);
    require(block.timestamp >= registrationTime, "registration not open");

    transferToken(_world(), MatchConfig.getEscrowContract(matchEntity), MatchSweepstake.getEntranceFee(matchEntity));

    return LibPlayerSetup.setup(_msgSender(), matchEntity, spawnIndex, heroChoice);
  }

  function registerFOW(
    bytes32 matchEntity, 
    uint256 spawnIndex, 
    bytes32 heroChoice,
    ZKProof calldata proof,
    uint256[8] calldata pubSignals
  ) public returns (bytes32) {
    require(checkAccessControl(matchEntity, _msgSender()), "caller is not allowed");
    require(SpawnReservedBy.get(matchEntity, spawnIndex) == 0, "spawn point already reserved");
    require(MatchPlayer.get(matchEntity, _msgSender()) == 0, "this account has already registered for the match");

    bool inRotation = HeroInRotation.get(heroChoice);
    require(
      inRotation || (hasSeasonPass(_msgSender()) && HeroInSeasonPassRotation.get(heroChoice)),
      "invalid hero choice"
    );

    bytes32 levelId = MatchConfig.getLevelId(matchEntity);
    require(LevelTemplates.getItem(levelId, spawnIndex) == SpawnSettlementTemplateId, "level entity is not a spawn");

    uint256 registrationTime = MatchConfig.getRegistrationTime(matchEntity);
    require(block.timestamp >= registrationTime, "registration not open");

    LevelPositionData memory levelPosition = LevelPosition.get(levelId, spawnIndex);

    // TODO: better type handling
    require(uint256(int256(levelPosition.x)) == pubSignals[5] - pubSignals[3], "pub sigs: x incorrect");
    require(uint256(int256(levelPosition.y)) == pubSignals[6] - pubSignals[4], "pub sigs: y incorrect");

    bytes32 pubSigHeroChoice = bytes32(pubSignals[7]);
    require(pubSigHeroChoice == heroChoice, "pub sigs: heroChoice incorrect");

    callSeismicSpawn(proof, pubSignals);

    transferToken(_world(), MatchConfig.getEscrowContract(matchEntity), MatchSweepstake.getEntranceFee(matchEntity));

    return LibPlayerSetup.setup(_msgSender(), matchEntity, spawnIndex, heroChoice);
  }
}
