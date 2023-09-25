// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./protocol-abc/Protocol.sol";
import "./interfaces/IM3tering_V1.sol";
import "./interfaces/ISolaxy.sol";

/// @custom:security-contact info@whynotswitch.com
contract M3tering_V1 is IM3tering_V1, Protocol {
    ISolaxy public constant SLX =
        ISolaxy(0x1CbAd85Aa66Ff3C12dc84C5881886EEB29C1bb9b); // TODO: add Solaxy address

    constructor() {
        if (address(SLX) == address(0)) revert ZeroAddress();
    }

    function claim(uint256 mintId) external whenNotPaused {
        uint256 amount = revenues[msg.sender];
        if (amount < 1) revert InputIsZero();
        revenues[msg.sender] = 0;

        if (!DAI.approve(address(SLX), amount)) revert Unauthorized();
        SLX.mint(amount, mintId);
        emit Claim(msg.sender, amount, block.timestamp);
    }

    function estimateReward(address owner) external view returns (uint256) {
        return SLX.estimateMint(revenues[owner]);
    }
}
