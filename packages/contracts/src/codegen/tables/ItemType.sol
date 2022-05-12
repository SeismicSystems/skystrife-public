// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

/* Autogenerated file. Do not edit manually. */

// Import schema type
import { SchemaType } from "@latticexyz/schema-type/src/solidity/SchemaType.sol";

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout, FieldLayoutLib } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema, SchemaLib } from "@latticexyz/store/src/Schema.sol";
import { PackedCounter, PackedCounterLib } from "@latticexyz/store/src/PackedCounter.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE, RESOURCE_OFFCHAIN_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";

// Import user types
import { ItemTypes } from "./../common.sol";

ResourceId constant _tableId = ResourceId.wrap(
  bytes32(abi.encodePacked(RESOURCE_TABLE, bytes14(""), bytes16("ItemType")))
);
ResourceId constant ItemTypeTableId = _tableId;

FieldLayout constant _fieldLayout = FieldLayout.wrap(
  0x0001010001000000000000000000000000000000000000000000000000000000
);

library ItemType {
  /**
   * @notice Get the table values' field layout.
   * @return _fieldLayout The field layout for the table.
   */
  function getFieldLayout() internal pure returns (FieldLayout) {
    return _fieldLayout;
  }

  /**
   * @notice Get the table's key schema.
   * @return _keySchema The key schema for the table.
   */
  function getKeySchema() internal pure returns (Schema) {
    SchemaType[] memory _keySchema = new SchemaType[](2);
    _keySchema[0] = SchemaType.BYTES32;
    _keySchema[1] = SchemaType.BYTES32;

    return SchemaLib.encode(_keySchema);
  }

  /**
   * @notice Get the table's value schema.
   * @return _valueSchema The value schema for the table.
   */
  function getValueSchema() internal pure returns (Schema) {
    SchemaType[] memory _valueSchema = new SchemaType[](1);
    _valueSchema[0] = SchemaType.UINT8;

    return SchemaLib.encode(_valueSchema);
  }

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](2);
    keyNames[0] = "matchEntity";
    keyNames[1] = "entity";
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](1);
    fieldNames[0] = "value";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, getKeySchema(), getValueSchema(), getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get value.
   */
  function getValue(bytes32 matchEntity, bytes32 entity) internal view returns (ItemTypes value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return ItemTypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Get value.
   */
  function _getValue(bytes32 matchEntity, bytes32 entity) internal view returns (ItemTypes value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return ItemTypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Get value.
   */
  function get(bytes32 matchEntity, bytes32 entity) internal view returns (ItemTypes value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return ItemTypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Get value.
   */
  function _get(bytes32 matchEntity, bytes32 entity) internal view returns (ItemTypes value) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return ItemTypes(uint8(bytes1(_blob)));
  }

  /**
   * @notice Set value.
   */
  function setValue(bytes32 matchEntity, bytes32 entity, ItemTypes value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(uint8(value)), _fieldLayout);
  }

  /**
   * @notice Set value.
   */
  function _setValue(bytes32 matchEntity, bytes32 entity, ItemTypes value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(uint8(value)), _fieldLayout);
  }

  /**
   * @notice Set value.
   */
  function set(bytes32 matchEntity, bytes32 entity, ItemTypes value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(uint8(value)), _fieldLayout);
  }

  /**
   * @notice Set value.
   */
  function _set(bytes32 matchEntity, bytes32 entity, ItemTypes value) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked(uint8(value)), _fieldLayout);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord(bytes32 matchEntity, bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord(bytes32 matchEntity, bytes32 entity) internal {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(ItemTypes value) internal pure returns (bytes memory) {
    return abi.encodePacked(value);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dyanmic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(ItemTypes value) internal pure returns (bytes memory, PackedCounter, bytes memory) {
    bytes memory _staticData = encodeStatic(value);

    PackedCounter _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple(bytes32 matchEntity, bytes32 entity) internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](2);
    _keyTuple[0] = matchEntity;
    _keyTuple[1] = entity;

    return _keyTuple;
  }
}
