// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";

import { SeismicConfig } from "../codegen/index.sol";

contract SeismicSystem is System {
    modifier onlyValidator() {
        require(_msgSender() == SeismicConfig.getValidator(), "only seismic validator can call this function");
        _;
    }

    function setSeismicContractAddress(address seismicContractAddress) external onlyValidator {
        SeismicConfig.setSeismicContract(seismicContractAddress);
    }
}
