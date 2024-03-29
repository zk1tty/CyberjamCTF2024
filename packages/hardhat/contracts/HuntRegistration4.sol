// SPDX-License-Identifier: MIT
// hardcoded with values for testing
pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ICyberjamHuntBase.sol";

contract HuntRegistration4 is Ownable {
    enum Team { Cat, Dog } // Enum for the two teams

    struct Player {
        address addr;
        Team team;
        string codename;
    }

    Player[] private players; // Array of players instead of teams

    address[] private gameAddresses;

    address public PLAYER_ADDRESS_1 = 0x1111111111111111111111111111111111111111;
    address public PLAYER_ADDRESS_2 = 0x2222222222222222222222222222222222222222;
    address public PLAYER_ADDRESS_3 = 0x3333333333333333333333333333333333333333;

    // Events
    event PlayerRegistered(string codename, address indexed playerAddress, Team team);
    event TeamScoreUpdated(Team team, uint256 newScore);

    constructor() Ownable() {
// create 3 random players for testing, 2 for dog and 1 for dog
        players.push(Player(PLAYER_ADDRESS_1, Team.Dog, "Rex"));
        players.push(Player(PLAYER_ADDRESS_2, Team.Dog, "Buddy"));
        players.push(Player(PLAYER_ADDRESS_3, Team.Cat, "Whiskeyrs"));

        // add 3 game addresses for testing
    // add 3 game addresses for testing
    gameAddresses.push(address(0x4444444444444444444444444444444444444444));
    gameAddresses.push(address(0x5555555555555555555555555555555555555555));
    gameAddresses.push(address(0x6666666666666666666666666666666666666666));

    }

    function addGameAddress(address gameAddress) external onlyOwner {
        gameAddresses.push(gameAddress);
    }

    function register(Team team, string memory codename) external {
        players.push(Player(msg.sender, team, codename));
        emit PlayerRegistered(codename, msg.sender, team);
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

    function getIndividualPlayerScore(address playerAddress) external view returns (uint256) {
        uint256 playerScore = 0;
        for (uint256 i = 0; i < gameAddresses.length; i++) {
            if (ICyberjamHuntBase(gameAddresses[i]).hasNft(playerAddress)) {
                playerScore++;
            }
        }
        return playerScore;
    }

     // This function returns an array of all players
    function getAllPlayers() external view returns (Player[] memory) {
        return players;
    }

    function getNumberOfPlayers() external view returns (uint256) {
        return players.length;
    }

    function getGameAddress(uint256 gameId) external view returns (address) {
        return gameAddresses[gameId];
    }

    // A helper function to emit team scores for the front-end, can be triggered after each update
    function emitTeamScores() external onlyOwner {
        emit TeamScoreUpdated(Team.Cat, getTeamScore(Team.Cat));
        emit TeamScoreUpdated(Team.Dog, getTeamScore(Team.Dog));
    }

    function addPlayerAddress(address playerAddress, Team team, string memory codename) external onlyOwner {
        players.push(Player(playerAddress, team, codename));
    }

    
}
