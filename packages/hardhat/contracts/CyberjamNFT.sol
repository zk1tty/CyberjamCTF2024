// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol"; 
import "./interfaces/ICyberjamHuntBase.sol";
import "./base64-sol/base64.sol";

contract CyberjamNFT is ERC721, Ownable {
    enum Team { Cat, Dog } // Enum for the two teams

    struct Player {
        address addr;
        Team team;
        string codename;
    }

    Player[] public players; // Array of players instead of teams

    address[] private gameAddresses;

    uint256 internal tokenCounter;

    // Note: for looking up tokenId with playerAddress 
    mapping(address => uint256 tokenId) public tokenIdFromPlayerAddress;

    // Note: Put folder CID of image folder on IPFS 
    // FOLDER_CID:
    //   L Cat
    //      L 0.png
    //      L 1.png
    //      L 2.png
    //   L Dog
    //      L 0.png
    //      L 1.png
    //      L 2.png
    string public constant TOKEN_IMAGE_FOLDER_CID = "QmQ376dPDNZrKb2E2GVEaeTWxpMvLUvprn1tRRd4qtBT19";

    // Events
    event PlayerRegistered(string codename, address indexed playerAddress, Team team, uint256 score, uint256 level);

    constructor(address owner) ERC721("HuntRegisterNFT", "HRNFT") Ownable(owner){
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
        players.push(Player(msg.sender, team, codename));
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

    // score is used in tokenURI score attribute
    function getPlayerScore(address playerAddress) public view returns (uint256) {
        uint256 playerScore = 0;
        for (uint256 i = 0; i < gameAddresses.length; i++) {
            if (ICyberjamHuntBase(gameAddresses[i]).hasNft(playerAddress)) {
                playerScore++;
            }
        }
        return playerScore;
    }

    // for leaderboard page
    function getPlayersScores() public view returns (uint256[] memory) {
        uint256[] memory playerScores = new uint256[](30);
        for (uint256 i = 0; i < players.length; i++) {
            address plaerAddr = players[i].addr;
            playerScores[i] = getPlayerScore(plaerAddr);
        }
        return playerScores;
    }

    // level is used for NFT attributes
    function getPlayerLevel(address playerAddress) public view returns (uint256) {
        uint256 playerScore = getPlayerScore(playerAddress);
        uint256 level = 5 > playerScore && playerScore > 0
            ? 1
            : playerScore == 5
            ? 3
            : 0;
        return level;
    }

    // for leaderboard page
    function getPlayersLevels() public view returns (uint256[] memory) {
        uint256[] memory playerLevels = new uint256[](30);
        for (uint256 i = 0; i < players.length; i++) {
            address plaerAddr = players[i].addr;
            uint256 playerScore = getPlayerScore(plaerAddr);
            uint256 level = 5 > playerScore && playerScore > 0
            ? 1
            : playerScore == 5
            ? 3
            : 0;
            playerLevels[i] = level;
        }
        return playerLevels;
    }

    function getNumberOfPlayers() external view returns (uint256) {
        return players.length;
    }

    function getGameAddress(uint256 gameId) external view returns (address) {
        return gameAddresses[gameId];
    }

    function getPlayerInfo(address player) external view returns(Player memory){
        uint256 tokenId = tokenIdFromPlayerAddress[player];
        return players[tokenId];
    }

     // This function returns an array of all players
    function getAllPlayers() external view returns (Player[] memory) {
        return players;
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        uint256 score = getPlayerScore(players[tokenId].addr);
        string memory playerScore = Strings.toString(score);
        string memory playerLevel = Strings.toString(getPlayerLevel(players[tokenId].addr));
        string memory playerTeam = players[tokenId].team == Team.Cat ? "Kitty" : "Doge"; 
        string memory animalSound = players[tokenId].team == Team.Cat ? "Meow Meow" : "Woof Woof";
        string memory animal = players[tokenId].team == Team.Cat ? "cat" : "doge";
        string memory tokenURL = string.concat("ipfs://", TOKEN_IMAGE_FOLDER_CID, "/", playerTeam, "/", playerLevel, ".png");
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"You played at Cyphercon 2024. ',
                            animalSound,
                            '! You are a good ',
                            animal,
                            ' with ',
                            playerScore,
                            ' number of points.", ',
                            '"attributes": [{"trait_type": "Team", "value":',
                            playerTeam,
                            '}, {"trait_type": "Score", "value":',
                            playerScore,
                            '}, {"trait_type": "Level", "value":',
                            playerLevel,
                            '}], "image":"',
                            tokenURL,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    // Refresh: 
    function tokenURIByPlayer(address player) public view returns (string memory) {
        uint256 tokenId = tokenIdFromPlayerAddress[player];
        return tokenURI(tokenId);
    }


}