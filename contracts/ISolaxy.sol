// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ISolaxy {
    function mint(uint256 slxAmount, uint256 mintId) external;

    function estimateMint(uint256 slxAmount) external view returns (uint256);
}
