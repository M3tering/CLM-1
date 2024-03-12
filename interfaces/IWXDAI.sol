// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IWXDAI {
    function deposit() external payable;

    function approve(address, uint) external returns (bool);

    function transferFrom(address, address, uint) external returns (bool);
}
