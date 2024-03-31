// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./CyberJamHuntBase.sol";

contract E1 is CyberJamHuntBase {
    constructor() CyberJamHuntBase("E3") {}

    function mintNft(uint256 value) public {
        require(2 + value == 4, "Wrong value!");
        _mintNft();
    }
}