// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../protocol-abc/IProtocol.sol";

interface IM3tering_V1 is IProtocol {
    function claim(uint256 mintId) external;

    function estimateReward(address owner) external view returns (uint256);
}