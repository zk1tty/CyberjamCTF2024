// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./interfaces/ICyberjamHuntBase.sol";
import "base64-sol/base64.sol";

contract HuntRegisterNFT is ERC721("HuntRegisterNFT", "HRNFT"), Ownable {
    enum Team { Cat, Dog } // Enum for the two teams

    struct Player {
        address addr;
        Team team;
        string codename;
        uint256 score;
        uint256 level;
    }

    Player[] private players; // Array of players instead of teams

    address[] private gameAddresses;

    uint256 internal tokenCounter;

    // Note: for looking up tokenId with playerAddress 
    mapping(address => uint256 tokenId) public tokenIdFromPlayerAddress;

    // set Token URI
    string public constant TOKEN_IMAGE_URI = "";

    // TODO: FE integation test
    // Events
    event PlayerRegistered(string codename, address indexed playerAddress, Team team, uint256 score, uint256 level);
    event TeamScoreUpdated(Team team, uint256 newScore);

    constructor(address initialOwner) Ownable(initialOwner) {
        tokenCounter = 0;
    }

    function addGameAddress(address gameAddress) external onlyOwner {
        gameAddresses.push(gameAddress);
    }

    function registerPlayer(Team team, string memory codename) external {
        players.push(Player(msg.sender, team, codename, 0, 0));
        _safeMint(msg.sender, tokenCounter);
        tokenIdFromPlayerAddress[msg.sender] = tokenCounter ++;
        emit PlayerRegistered(codename, msg.sender, team, 0, 0);
    }

    // Note: The original function `kickTeam` has been omitted as it might not align with the new design.

    function getTeamScore(Team team) public view returns (uint256) {
        uint256 teamScore = 0;
        for (uint256 i = 0; i < players.length; i++) {
            if (players[i].team == team) {
                address playerAddress = players[i].addr;
                for (uint256 j = 0; j < gameAddresses.length; j++) {
                    if (ICyberjamHuntBase(gameAddresses[j]).hasNft(playerAddress)) {
                        teamScore++;
                    }
                }
            }
        }
        return teamScore;
    }

    function getIndividualPlayerScore(address playerAddress) public returns (uint256) {
        uint256 playerScore = 0;
        for (uint256 i = 0; i < gameAddresses.length; i++) {
            // TODO: Fetch the point from ICyberjamHuntBase
            if (ICyberjamHuntBase(gameAddresses[i]).hasNft(playerAddress)) {
                playerScore++;
            }
        }
        uint256 tokenId = tokenIdFromPlayerAddress[playerAddress];
        players[tokenId].score = playerScore;
        return playerScore;
    }

    function getIndividualPlayerLevel(address playerAddress) public returns (uint256) {
        uint256 playerScore = getIndividualPlayerScore(playerAddress);
        uint256 level = 5 > playerScore && playerScore > 0
            ? 1
            : playerScore == 5
            ? 3
            : 0;

        uint256 tokenId = tokenIdFromPlayerAddress[playerAddress];
        players[tokenId].level = level;
        return level;
    }

    function getNumberOfPlayers() external view returns (uint256) {
        return players.length;
    }

    function getGameAddress(uint256 gameId) external view returns (address) {
        return gameAddresses[gameId];
    }

    // TODO: update 
    // A helper function to emit team scores for the front-end, can be triggered after each update
    function emitTeamScores() external onlyOwner {
        emit TeamScoreUpdated(Team.Cat, getTeamScore(Team.Cat));
        emit TeamScoreUpdated(Team.Dog, getTeamScore(Team.Dog));
    }

    // TODO: Why do we need this?
    // function addPlayerAddress(address playerAddress, Team team, string memory codename) external onlyOwner {
    //     players.push(Player(playerAddress, team, codename, score));
    // }

    // Dynamic Token // how to get dynamic valueeee!
    // Player memory player = players[tokenId];
    function tokenURI(uint256 tokenId) public view override returns (string memory) {

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"You captured this NFT as part of the Hunt!", ',
                            '"attributes": [{"trait_type": "skills", "value":',
                            players[tokenId].score,
                            '}], "image":"',
                            TOKEN_IMAGE_URI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
