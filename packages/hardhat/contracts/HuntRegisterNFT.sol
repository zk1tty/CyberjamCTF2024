// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 
import "./interfaces/ICyberjamHuntBase.sol";
import "./base64-sol/base64.sol";

contract HuntRegisterNFT is ERC721, Ownable {
    enum Team { Cat, Dog } // Enum for the two teams

    struct Player {
        address addr;
        Team team;
        string codename;
        uint256 score;
        uint256 level;
    }

    Player[] public players; // Array of players instead of teams

    address[] private gameAddresses;

    uint256 internal tokenCounter;

    // Note: for looking up tokenId with playerAddress 
    mapping(address => uint256 tokenId) public tokenIdFromPlayerAddress;

    // TODO: set Token URI
    string public constant TOKEN_IMAGE_URI = "";

    // TODO: FE integation test
    // Events
    event PlayerRegistered(string codename, address indexed playerAddress, Team team, uint256 score, uint256 level);
    event TeamScoreUpdated(Team team, uint256 newScore);

    constructor() ERC721("HuntRegisterNFT", "HRNFT"){
        tokenCounter = 0;
    }

    // note: Onwer Pre Operation
    function addGameAddress(address gameAddress) external onlyOwner {
        gameAddresses.push(gameAddress);
    }

    function _stringToTeam(string memory teamString) private pure returns (Team) {
        if (keccak256(abi.encodePacked(teamString)) == keccak256(abi.encodePacked("Cat"))) {
            return Team.Cat;
        } else if (keccak256(abi.encodePacked(teamString)) == keccak256(abi.encodePacked("Dog"))) {
            return Team.Dog;
        } else {
            revert("Invalid team string");
        }
    }

    function registerPlayerAndMintNft(string memory teamString, string memory codename) external {
        Team team = _stringToTeam(teamString);
        players.push(Player(msg.sender, team, codename, 0, 0));
        _safeMint(msg.sender, tokenCounter);
        tokenIdFromPlayerAddress[msg.sender] = tokenCounter ++;
        emit PlayerRegistered(codename, msg.sender, team, 0, 0);
    }

    // Note: The original function `kickTeam` has been omitted as it might not align with the new design.

    function getTeamScore(string memory teamString) public view returns (uint256) {
        Team team = _stringToTeam(teamString);
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

    // Note: Score used for NFT attributes
    function updatePlayerScore(address playerAddress) public returns (uint256) {
        uint256 playerScore = 0;
        for (uint256 i = 0; i < gameAddresses.length; i++) {
            if (ICyberjamHuntBase(gameAddresses[i]).hasNft(playerAddress)) {
                playerScore++;
            }
        }
        uint256 tokenId = tokenIdFromPlayerAddress[playerAddress];
        players[tokenId].score = playerScore;
        return playerScore;
    }

    // Level used for NFT attributes
    function updatePlayerLevel(address playerAddress) public returns (uint256) {
        uint256 playerScore = updatePlayerScore(playerAddress);
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

    function getPlayerInfo(uint256 tokenId) public view returns (uint256) {
        return players[tokenId].score;
    }

    // Q: Why do we need this?
    // function addPlayerAddress(address playerAddress, Team team, string memory codename) external onlyOwner {
    //     players.push(Player(playerAddress, team, codename, score));
    // }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }
    // Note: on nftMinted() evnet, 
    // updatePlayerScore, updatePlayerLevel() have to be called to fetch the latest score.
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory playerScore = Strings.toString(players[tokenId].score);
        string memory playerLevel = Strings.toString(players[tokenId].level);
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"You captured this NFT as part of the Hunt!", ',
                            '"attributes": [{"trait_type": "Score", "value":',
                            playerScore,
                            '}, {"trait_type": "Level", "value":',
                            playerLevel,
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
