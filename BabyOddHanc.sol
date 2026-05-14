// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

/**
 * @title BabyOddHanc
 * @notice Fixed-supply ERC20 token with burn and EIP-2612 permit support
 * @dev Immutable, ownerless, non-upgradeable, and fully decentralized
 */
contract BabyOddHanc is ERC20, ERC20Burnable, ERC20Permit {
    /// @notice Maximum token supply (18 decimals)
    uint256 public constant MAX_SUPPLY = 520_851_852_113 * 1e18;

    /// @notice Reverts when attempting to burn zero tokens
    error ZeroBurnAmount();

    /**
     * @notice Emitted when tokens are permanently burned
     * @param burner Address performing the burn
     * @param amount Amount of tokens burned
     */
    event TokensBurned(address indexed burner, uint256 amount);

    /**
     * @notice Deploys the token and mints the full supply to the deployer
     */
    constructor()
        ERC20("BabyOddHanc", "BABYHANC")
        ERC20Permit("BabyOddHanc")
    {
        _mint(msg.sender, MAX_SUPPLY);
    }

    /**
     * @notice Permanently burns caller-owned tokens
     * @param amount Amount of tokens to burn
     */
    function burn(uint256 amount) public override {
        if (amount == 0) revert ZeroBurnAmount();

        super.burn(amount);

        emit TokensBurned(msg.sender, amount);
    }

    /**
     * @notice Permanently burns approved tokens from another account
     * @param account Address tokens are burned from
     * @param amount Amount of tokens to burn
     */
    function burnFrom(address account, uint256 amount) public override {
        if (amount == 0) revert ZeroBurnAmount();

        super.burnFrom(account, amount);

        emit TokensBurned(account, amount);
    }
}