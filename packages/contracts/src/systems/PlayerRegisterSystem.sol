// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { SystemSwitch } from "@latticexyz/world-modules/src/utils/SystemSwitch.sol";

import { SkyPoolConfig, MatchAccessControl, MatchSweepstake, LevelTemplates, MatchConfig, Player, SpawnPoint, SpawnReservedBy, Position, PositionData, MatchSpawnPoints } from "../codegen/index.sol";
import { MatchAccessControl, LevelTemplates, MatchConfig, Player, SpawnPoint, SpawnReservedBy, Position, PositionData, MatchSpawnPoints, HeroInRotation, HeroInSeasonPassRotation, MatchPlayer, LevelPosition, LevelPositionData, SpawnReservedBy, SeismicConfig } from "../codegen/index.sol";
import { SpawnSettlementTemplateId } from "../codegen/Templates.sol";

import { IAllowSystem } from "../IAllowSystem.sol";
import { transferToken } from "../transferToken.sol";
import { hasSeasonPass } from "../hasToken.sol";

import { LibPlayerSetup } from "base/libraries/LibPlayerSetup.sol";
import { getLevelSpawnIndices } from "../libraries/LibUtils.sol";

import { ZKProof, SpawnInputs, PlayerActionSignature, getPlayerFromSpawnSig, callSeismicSpawn } from "../libraries/LibSeismic.sol";

import { createPlayerEntity } from "../libraries/LibPlayer.sol";
import { startMatchIfAllRegistered } from "../libraries/LibMatch.sol";

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
    SpawnInputs calldata spawnInputs,
    ZKProof calldata spawnProof,
    PlayerActionSignature calldata signature
  ) public returns (bytes32 player) {
    require(msg.sender == SeismicConfig.getValidator(), "Only the seismic validator can call this function");

    address playerAddress = getPlayerFromSpawnSig(spawnInputs, signature);

    require(checkAccessControl(spawnInputs.matchEntity, playerAddress), "caller is not allowed");
    require(MatchPlayer.get(spawnInputs.matchEntity, playerAddress) == 0, "this account has already registered for the match");

    bool inRotation = HeroInRotation.get(spawnInputs.heroChoice);
    require(
      inRotation || (hasSeasonPass(playerAddress) && HeroInSeasonPassRotation.get(spawnInputs.heroChoice)),
      "invalid hero choice"
    );

    bytes32 levelId = MatchConfig.getLevelId(spawnInputs.matchEntity);
    uint256[] memory spawnIndices = getLevelSpawnIndices(levelId);
    require(spawnInputs.spawnIndex < spawnIndices.length, "spawn index out of bounds");

    uint256 spawnIndex = spawnIndices[spawnInputs.spawnIndex];

    require(SpawnReservedBy.get(spawnInputs.matchEntity, spawnIndex) == 0, "spawn point already reserved");
    require(LevelTemplates.getItem(levelId, spawnIndex) == SpawnSettlementTemplateId, "level entity is not a spawn");

    uint256 registrationTime = MatchConfig.getRegistrationTime(spawnInputs.matchEntity);
    require(block.timestamp >= registrationTime, "registration not open");

    callSeismicSpawn(spawnInputs, spawnProof);

    transferToken(_world(), MatchConfig.getEscrowContract(spawnInputs.matchEntity), MatchSweepstake.getEntranceFee(spawnInputs.matchEntity));

    player = createPlayerEntity(spawnInputs.matchEntity, playerAddress);
    SpawnReservedBy.set(spawnInputs.matchEntity, spawnIndex, player);

    startMatchIfAllRegistered(spawnInputs.matchEntity);
  }
}
