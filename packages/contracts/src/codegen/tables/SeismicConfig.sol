// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

/* Autogenerated file. Do not edit manually. */

// Import store internals
import { IStore } from "@latticexyz/store/src/IStore.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { StoreCore } from "@latticexyz/store/src/StoreCore.sol";
import { Bytes } from "@latticexyz/store/src/Bytes.sol";
import { Memory } from "@latticexyz/store/src/Memory.sol";
import { SliceLib } from "@latticexyz/store/src/Slice.sol";
import { EncodeArray } from "@latticexyz/store/src/tightcoder/EncodeArray.sol";
import { FieldLayout } from "@latticexyz/store/src/FieldLayout.sol";
import { Schema } from "@latticexyz/store/src/Schema.sol";
import { EncodedLengths, EncodedLengthsLib } from "@latticexyz/store/src/EncodedLengths.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";

struct SeismicConfigData {
  address validator;
  address seismicContract;
  uint256 blindCommitment;
}

library SeismicConfig {
  // Hex below is the result of `WorldResourceIdLib.encode({ namespace: "", name: "SeismicConfig", typeId: RESOURCE_TABLE });`
  ResourceId constant _tableId = ResourceId.wrap(0x74620000000000000000000000000000536569736d6963436f6e666967000000);

  FieldLayout constant _fieldLayout =
    FieldLayout.wrap(0x0048030014142000000000000000000000000000000000000000000000000000);

  // Hex-encoded key schema of ()
  Schema constant _keySchema = Schema.wrap(0x0000000000000000000000000000000000000000000000000000000000000000);
  // Hex-encoded value schema of (address, address, uint256)
  Schema constant _valueSchema = Schema.wrap(0x0048030061611f00000000000000000000000000000000000000000000000000);

  /**
   * @notice Get the table's key field names.
   * @return keyNames An array of strings with the names of key fields.
   */
  function getKeyNames() internal pure returns (string[] memory keyNames) {
    keyNames = new string[](0);
  }

  /**
   * @notice Get the table's value field names.
   * @return fieldNames An array of strings with the names of value fields.
   */
  function getFieldNames() internal pure returns (string[] memory fieldNames) {
    fieldNames = new string[](3);
    fieldNames[0] = "validator";
    fieldNames[1] = "seismicContract";
    fieldNames[2] = "blindCommitment";
  }

  /**
   * @notice Register the table with its config.
   */
  function register() internal {
    StoreSwitch.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Register the table with its config.
   */
  function _register() internal {
    StoreCore.registerTable(_tableId, _fieldLayout, _keySchema, _valueSchema, getKeyNames(), getFieldNames());
  }

  /**
   * @notice Get validator.
   */
  function getValidator() internal view returns (address validator) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get validator.
   */
  function _getValidator() internal view returns (address validator) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 0, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set validator.
   */
  function setValidator(address validator) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((validator)), _fieldLayout);
  }

  /**
   * @notice Set validator.
   */
  function _setValidator(address validator) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 0, abi.encodePacked((validator)), _fieldLayout);
  }

  /**
   * @notice Get seismicContract.
   */
  function getSeismicContract() internal view returns (address seismicContract) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Get seismicContract.
   */
  function _getSeismicContract() internal view returns (address seismicContract) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 1, _fieldLayout);
    return (address(bytes20(_blob)));
  }

  /**
   * @notice Set seismicContract.
   */
  function setSeismicContract(address seismicContract) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((seismicContract)), _fieldLayout);
  }

  /**
   * @notice Set seismicContract.
   */
  function _setSeismicContract(address seismicContract) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 1, abi.encodePacked((seismicContract)), _fieldLayout);
  }

  /**
   * @notice Get blindCommitment.
   */
  function getBlindCommitment() internal view returns (uint256 blindCommitment) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreSwitch.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Get blindCommitment.
   */
  function _getBlindCommitment() internal view returns (uint256 blindCommitment) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    bytes32 _blob = StoreCore.getStaticField(_tableId, _keyTuple, 2, _fieldLayout);
    return (uint256(bytes32(_blob)));
  }

  /**
   * @notice Set blindCommitment.
   */
  function setBlindCommitment(uint256 blindCommitment) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((blindCommitment)), _fieldLayout);
  }

  /**
   * @notice Set blindCommitment.
   */
  function _setBlindCommitment(uint256 blindCommitment) internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setStaticField(_tableId, _keyTuple, 2, abi.encodePacked((blindCommitment)), _fieldLayout);
  }

  /**
   * @notice Get the full data.
   */
  function get() internal view returns (SeismicConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreSwitch.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Get the full data.
   */
  function _get() internal view returns (SeismicConfigData memory _table) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    (bytes memory _staticData, EncodedLengths _encodedLengths, bytes memory _dynamicData) = StoreCore.getRecord(
      _tableId,
      _keyTuple,
      _fieldLayout
    );
    return decode(_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function set(address validator, address seismicContract, uint256 blindCommitment) internal {
    bytes memory _staticData = encodeStatic(validator, seismicContract, blindCommitment);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using individual values.
   */
  function _set(address validator, address seismicContract, uint256 blindCommitment) internal {
    bytes memory _staticData = encodeStatic(validator, seismicContract, blindCommitment);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function set(SeismicConfigData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.validator, _table.seismicContract, _table.blindCommitment);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Set the full data using the data struct.
   */
  function _set(SeismicConfigData memory _table) internal {
    bytes memory _staticData = encodeStatic(_table.validator, _table.seismicContract, _table.blindCommitment);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.setRecord(_tableId, _keyTuple, _staticData, _encodedLengths, _dynamicData, _fieldLayout);
  }

  /**
   * @notice Decode the tightly packed blob of static data using this table's field layout.
   */
  function decodeStatic(
    bytes memory _blob
  ) internal pure returns (address validator, address seismicContract, uint256 blindCommitment) {
    validator = (address(Bytes.getBytes20(_blob, 0)));

    seismicContract = (address(Bytes.getBytes20(_blob, 20)));

    blindCommitment = (uint256(Bytes.getBytes32(_blob, 40)));
  }

  /**
   * @notice Decode the tightly packed blobs using this table's field layout.
   * @param _staticData Tightly packed static fields.
   *
   *
   */
  function decode(
    bytes memory _staticData,
    EncodedLengths,
    bytes memory
  ) internal pure returns (SeismicConfigData memory _table) {
    (_table.validator, _table.seismicContract, _table.blindCommitment) = decodeStatic(_staticData);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function deleteRecord() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreSwitch.deleteRecord(_tableId, _keyTuple);
  }

  /**
   * @notice Delete all data for given keys.
   */
  function _deleteRecord() internal {
    bytes32[] memory _keyTuple = new bytes32[](0);

    StoreCore.deleteRecord(_tableId, _keyTuple, _fieldLayout);
  }

  /**
   * @notice Tightly pack static (fixed length) data using this table's schema.
   * @return The static data, encoded into a sequence of bytes.
   */
  function encodeStatic(
    address validator,
    address seismicContract,
    uint256 blindCommitment
  ) internal pure returns (bytes memory) {
    return abi.encodePacked(validator, seismicContract, blindCommitment);
  }

  /**
   * @notice Encode all of a record's fields.
   * @return The static (fixed length) data, encoded into a sequence of bytes.
   * @return The lengths of the dynamic fields (packed into a single bytes32 value).
   * @return The dynamic (variable length) data, encoded into a sequence of bytes.
   */
  function encode(
    address validator,
    address seismicContract,
    uint256 blindCommitment
  ) internal pure returns (bytes memory, EncodedLengths, bytes memory) {
    bytes memory _staticData = encodeStatic(validator, seismicContract, blindCommitment);

    EncodedLengths _encodedLengths;
    bytes memory _dynamicData;

    return (_staticData, _encodedLengths, _dynamicData);
  }

  /**
   * @notice Encode keys as a bytes32 array using this table's field layout.
   */
  function encodeKeyTuple() internal pure returns (bytes32[] memory) {
    bytes32[] memory _keyTuple = new bytes32[](0);

    return _keyTuple;
  }
}
