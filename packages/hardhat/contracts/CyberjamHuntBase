// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

contract CyberjamHuntBase is ERC721 {
    string public constant TOKEN_IMAGE_URI =
        "attachments/1217126145334575205/1221931759965311047/Cyberjammers.png?ex=66145fa1&is=6601eaa1&hm=26df4de5d5003f8ae903558fd149a84539ca050e8ecb656149835ac3e25a5d64&";
    uint256 internal s_tokenCounter;
    mapping(address => bool) public s_hasNft;

    constructor(string memory level) ERC721(string.concat("CyberJam Hunt NFT | ", level), "S2S") {
        s_tokenCounter = 0;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "https://cdn.discordapp.com/";
    }

    function _mintByAddress(address addr) internal {
        _safeMint(addr, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        s_hasNft[addr] = true;
    }

    function _mintNft() internal {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        s_hasNft[msg.sender] = true;
    }

    function tokenURI(uint256 /* tokenId */ ) public view override returns (string memory) {
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"You captured this NFT as part of the Hunt!", ',
                            '"attributes": [{"trait_type": "skills", "value": 100}], "image":"',
                            TOKEN_IMAGE_URI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function hasNft(address addr) public view returns (bool) {
        return s_hasNft[addr];
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}