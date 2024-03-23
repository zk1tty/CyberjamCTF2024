// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/ICyberjamHuntBase.sol";

contract HuntRegistration is Ownable {
    struct Team {
        address addr;
        string name;
    }

    Team[] private s_teams;

    address[] private s_gameAddresses;

    constructor() Ownable() {}

    function addGameAddress(address gameAddress) external onlyOwner {
        s_gameAddresses.push(gameAddress);
    }

    function register(address addr, string memory teamName) external {
        Team memory newTeam = Team(addr, teamName);
        s_teams.push(newTeam);
    }

    function kickTeam(uint256 teamId) external onlyOwner {
        s_teams[teamId] = Team(address(0), "");
    }

    function getTeam(uint256 teamId) external view returns (Team memory) {
        return s_teams[teamId];
    }

    function getGameAddress(uint256 gameId) external view returns (address) {
        return s_gameAddresses[gameId];
    }

    /*
     * Just remember, this is only the EVM scores!
     */
    function getTeamScoreById(uint256 teamIndex) public view returns (uint256) {
        uint256 teamScore = 0;
        address teamAddress = s_teams[teamIndex].addr;
        for (uint256 i = 0; i < s_gameAddresses.length; i++) {
            address gameAddress = s_gameAddresses[i];
            if (ICyberJamHuntBase(gameAddress).s_hasNft(teamAddress)) {
                teamScore = teamScore + 1;
            }
        }
        return teamScore;
    }

    /*
     * Just remember, this is only the EVM scores!
     */
    function getTeamScoreByAddress(address teamAddress) external view returns (uint256) {
        for (uint256 i = 0; i < s_teams.length; i++) {
            if (s_teams[i].addr == teamAddress) {
                return getTeamScoreById(i);
            }
        }
        return 0;
    }

    function getNumberOfTeams() external view returns (uint256) {
        return s_teams.length;
    }

    function getTeamScores() external view returns (uint256[] memory) {
        uint256[] memory teamScores = new uint256[](s_teams.length);
        for (uint256 i = 0; i < s_teams.length; i++) {
            uint256 score = getTeamScoreById(i);
            teamScores[i] = score;
        }
        return teamScores;
    }

    function setAddress(uint256 index, address addr) public onlyOwner {
        s_gameAddresses[index] = addr;
    }
}