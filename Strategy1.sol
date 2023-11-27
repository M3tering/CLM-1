// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.3/contracts/token/ERC20/IERC20.sol";
import "./interfaces/IStrategy.sol";
import "./interfaces/ISolaxy.sol";

/// @custom:security-contact info@whynotswitch.com
contract Strategy1 is IStrategy {
    error TransferError();

    IERC20 public constant DAI =
        IERC20(0x1CbAd85Aa66Ff3C12dc84C5881886EEB29C1bb9b);
    ISolaxy public constant SLX =
        ISolaxy(0x1CbAd85Aa66Ff3C12dc84C5881886EEB29C1bb9b); // TODO: add Solaxy address

    function claim(uint256 assets, bytes calldata data) external {
        (address receiver, uint256 minSharesOut) = abi.decode(
            data,
            (address, uint256)
        );
        if (!DAI.transferFrom(msg.sender, receiver, assets))
            revert TransferError();
        SLX.safeDeposit(assets, receiver, minSharesOut);
    }
}
