// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

interface ICyberjamHuntBase {
    function hasNft(address addr) external view returns (bool);
    function s_hasNft(address addr) external view returns (bool);
}