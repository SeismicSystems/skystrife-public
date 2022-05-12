// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import { IStore } from "@latticexyz/store/src/IStore.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { PackedCounter } from "@latticexyz/store/src/PackedCounter.sol";

import { TemplateTables, TemplateContent } from "../../codegen/index.sol";

/**
 * Create a template.
 */
function createTemplate(
  bytes32 templateId,
  bytes32[] memory tableIds,
  bytes[] memory staticDatas,
  bytes32[] memory encodedLengthss,
  bytes[] memory dynamicDatas
) {
  TemplateTables.set(templateId, tableIds);

  for (uint256 i; i < tableIds.length; i++) {
    TemplateContent.set(
      templateId,
      ResourceId.wrap(tableIds[i]),
      PackedCounter.wrap(encodedLengthss[i]),
      staticDatas[i],
      dynamicDatas[i]
    );
  }
}
