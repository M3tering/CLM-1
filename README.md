# `CLM-1` : Claim Logic Module for minting SLX 

This contract provides a simple and secure way for users to convert their xDai revenues on the M3tering protocol to Solaxy tokens.


**How it works:**
* Users calls the claim function to send xDAI, along with abi encoded calldata to the contract
* The contract wraps xDai received from the user using the WXDAI contract.
* Wrapped xDai is then deposited into the savings-DAI vault (an interest-bearing vault by MakerDAO) for the equivalent in sDAI.
* Finally, the sDAI is used as collateral to issue new SLX tokens on the Solaxy bonding curve.
