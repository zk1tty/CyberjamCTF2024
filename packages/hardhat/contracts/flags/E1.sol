// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./FlagNFTBase.sol";

contract E1 is FlagNFTBase {
    constructor() FlagNFTBase("E", "1") {}

    // Note: off-chain event listener listerns to event nftMinted() 
    function mintNft(uint256 value) public {
        require(2 + value == 4, "Wrong value!");
        _mintNft();
    }
}