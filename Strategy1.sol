// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v5.0.2/contracts/interfaces/IERC4626.sol";
import "./interfaces/IStrategy.sol";
import "./interfaces/ISolaxy.sol";
import "./interfaces/IWXDAI.sol";

/// @custom:security-contact info@whynotswitch.com
contract Strategy1 is IStrategy {
    error TransferErrorXDAI();
    error UnauthorizedSDAI();
    error UnauthorizedSLX();

    IWXDAI public constant WXDAI =
        IWXDAI(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);
    IERC4626 public constant SDAI =
        IERC4626(0xaf204776c7245bF4147c2612BF6e5972Ee483701);
    ISolaxy public constant SLX =
        ISolaxy(0x1CbAd85Aa66Ff3C12dc84C5881886EEB29C1bb9b); // TODO: add Solaxy address

    function claim(bytes calldata data) external payable {
        (address receiver, uint256 minSharesOut) = abi.decode(
            data,
            (address, uint256)
        );

        // Wrap xDAI msg.value
        WXDAI.deposit{value: msg.value}();

        // deposit wrapped xDAI for sDAI
        if (!WXDAI.approve(address(SDAI), msg.value)) revert UnauthorizedSDAI();
        SDAI.deposit(msg.value, receiver);
        uint256 amountSDAI = SDAI.balanceOf(address(this));

        // deposit sDAI to mint Solaxy
        if (!SDAI.approve(address(SLX), amountSDAI)) revert UnauthorizedSLX();
        SLX.safeDeposit(amountSDAI, receiver, minSharesOut);
    }
}
