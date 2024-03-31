// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./CyberjamHuntBase.sol";

contract E1 is CyberjamHuntBase {
    constructor() CyberjamHuntBase("E1") {}

    function mintNft(uint256 value) public {
        require(2 + value == 4, "Wrong value!");
        _mintNft();
    }
}