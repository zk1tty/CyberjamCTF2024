// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

contract CyberjamHuntBase is ERC721 {
    // Note:  file structure 
    // cyberjam(TOKEN_IMAGE_FOLDER)
    //   L E1.png
    //   L E2.png
    //   L M1.png
    //   L M2.png
    string public constant TOKEN_IMAGE_FOLDER = "QmXUC1dwxchyA5Y7wDV8c7WTQDuYjBfPE4kW1rw8tTLN2c";
    uint256 internal s_tokenCounter;
    mapping(address => bool) public s_hasNft;
    // Note: 0-4 currently,
    // Update: e1-e3, m1-m3
    string difficulty;

    event nftMinted(string difficulty, address player);

    constructor(string memory _difficulty) ERC721(string.concat("CyberJam Hunt NFT | ", _difficulty), "CVSD24") {
        s_tokenCounter = 0;
        difficulty = _difficulty;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function _mintByAddress(address addr) internal {
        _safeMint(addr, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        s_hasNft[addr] = true;
    }

    // Note: off-chain event listerner listens to nftMinted event.
    function _mintNft() internal {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        s_hasNft[msg.sender] = true;
        emit nftMinted(difficulty, msg.sender);
    }

    function tokenURI(uint256 /* tokenId */ ) public view override returns (string memory) {
        string memory tokenURL = string.concat("ipfs://", TOKEN_IMAGE_FOLDER, "/", difficulty, ".png");
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
                            tokenURL,
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