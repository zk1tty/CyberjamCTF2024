// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ICyberjamHuntBase.sol";

contract HuntRegistration1 is Ownable {
    enum Team { Cat, Dog }

    struct Player {
        address addr;
        Team team;
    }

    // Array of players
    Player[] private players;

    // Mapping from team to their scores
    mapping(Team => uint256) private teamScores;

    // Addresses of the game contracts
    address[] private gameAddresses;

    // Events
    event PlayerRegistered(address indexed playerAddress, Team team);
    event TeamScoreUpdated(Team team, uint256 newScore);

    constructor() Ownable() {}

    function addGameAddress(address gameAddress) external onlyOwner {
        require(gameAddress != address(0), "Invalid game address");
        gameAddresses.push(gameAddress);
    }

    function register(Team team) external {
        players.push(Player(msg.sender, team));
        emit PlayerRegistered(msg.sender, team);
    }

    /*
     * Update scores for teams by checking each game contract.
     * This function could be optimized or adjusted based on the actual game mechanics.
     */
    function updateTeamScores() external onlyOwner {
        // Reset scores before calculation
        teamScores[Team.Cat] = 0;
        teamScores[Team.Dog] = 0;

        for (uint256 i = 0; i < players.length; i++) {
            for (uint256 j = 0; j < gameAddresses.length; j++) {
                if (ICyberjamHuntBase(gameAddresses[j]).hasNft(players[i].addr)) {
                    teamScores[players[i].team] += 1;
                }
            }
        }

        emit TeamScoreUpdated(Team.Cat, teamScores[Team.Cat]);
        emit TeamScoreUpdated(Team.Dog, teamScores[Team.Dog]);
    }

    function getTeamScore(Team team) external view returns (uint256) {
        return teamScores[team];
    }

    function getNumberOfPlayers() external view returns (uint256) {
        return players.length;
    }

    function getGameAddress(uint256 gameId) external view returns (address) {
        require(gameId < gameAddresses.length, "Invalid game ID");
        return gameAddresses[gameId];
    }

    // Utility function to clear game addresses, primarily for resetting or updating the game logic.
    function clearGameAddresses() external onlyOwner {
        delete gameAddresses;
    }
}
