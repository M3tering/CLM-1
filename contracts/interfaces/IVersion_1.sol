// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./IM3tering.sol";

interface IVersion_1 is IM3tering {
    function claim(uint256 mintId) external;

    function estimateReward() external view returns (uint256);
}