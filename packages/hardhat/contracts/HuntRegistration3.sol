// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ICyberjamHuntBase.sol";

contract HuntRegistration3 is Ownable {
    enum Team { Cat, Dog } // Enum for the two teams

    struct Player {
        address addr;
        Team team;
        string codename;
    }

    Player[] private players; // Array of players instead of teams

    address[] private gameAddresses;

    // Events
    event PlayerRegistered(string codename, address indexed playerAddress, Team team);
    event TeamScoreUpdated(Team team, uint256 newScore);

    constructor() Ownable() {}

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
