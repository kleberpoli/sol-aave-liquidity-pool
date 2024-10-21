// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/**
 * @title Aave Liquidity Pool
 * @dev A simple liquidity pool for Aave tokens (AAVE), allowing deposits and withdrawals.
 */
interface IERC20 {
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
}

contract LiquidityPool {

    // AAVE token contract address
    address public immutable aaveToken;
	
    // Owner of the pool
    address public owner;
    
    // Mapping to track user balances
    mapping(address => uint256) public balances;

    // Event emitted when tokens are deposited
    event Deposit(address indexed user, uint256 amount);
	
    // Event emitted when tokens are withdrawn
    event Withdraw(address indexed user, uint256 amount);
    
    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    /**
     * @dev Constructor to set the AAVE token address and owner.
     * @param _aaveToken Address of the AAVE token contract.
     */
    constructor(address _aaveToken) {
        aaveToken = _aaveToken;
        owner = msg.sender;
    }

    /**
     * @dev Function to deposit AAVE tokens into the pool.
     * @param _amount Amount of tokens to deposit.
     */
    function deposit(uint256 _amount) external {
	
        require(_amount > 0, "Deposit amount must be greater than 0");

        // Transfer AAVE tokens from user to this contract
        IERC20(aaveToken).transferFrom(msg.sender, address(this), _amount);

        // Update user's balance
        balances[msg.sender] += _amount;

        emit Deposit(msg.sender, _amount);
    }

    /**
     * @dev Function to withdraw AAVE tokens from the pool.
     * @param _amount Amount of tokens to withdraw.
     */
    function withdraw(uint256 _amount) external {
	
        require(_amount > 0, "Withdrawal amount must be greater than 0");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        // Transfer AAVE tokens back to the user
        IERC20(aaveToken).transfer(msg.sender, _amount);

        // Update user's balance
        balances[msg.sender] -= _amount;

        emit Withdraw(msg.sender, _amount);
    }

    /**
     * @dev Allows the owner to withdraw the contract's entire balance (emergency only).
     */
    function emergencyWithdraw() external onlyOwner {
        uint256 contractBalance = IERC20(aaveToken).balanceOf(address(this));
        require(contractBalance > 0, "Contract balance is 0");
        IERC20(aaveToken).transfer(owner, contractBalance);
    }
}