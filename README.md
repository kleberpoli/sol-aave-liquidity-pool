# Aave Liquidity Pool Smart Contract

This project demonstrates a simple liquidity pool smart contract that allows users to deposit and withdraw Aave tokens (AAVE).

## Features
- **Deposit/Withdraw:** Users can deposit Aave tokens into the pool and withdraw their tokens.
- **Security:** The contract is designed with security best practices like access control and use of immutable variables.

## How to Use
1. **Clone the repository**:
   ```bash
   git clone https://github.com/kleberpoli/sol-aave-liquidity-pool.git
   cd aave-liquidity-pool
   ```

2. **Install dependencies**:
   ```bash
	npm install
   ```

3. **Test the contract**:

   ```bash
	npx hardhat test
   ```

## Testing with Hardhat
1. **Install dependencies**:

   ```bash
	npm install --save-dev hardhat @nomiclabs/hardhat-ethers ethers
   ```

2. **Test file example (test/LiquidityPool.js)**:

3. **Run tests**:

   ```bash
	npx hardhat test
   ```

## Security Best Practices
- **Use of SafeMath:** In versions prior to 0.8.x, we’d use libraries like `SafeMath` to avoid overflow and underflow issues. Solidity 0.8.x natively protects against these, so it's no longer needed.
- **Reentrancy Protection:** For advanced cases, consider using the `ReentrancyGuard` modifier. This is not included here since the contract is relatively simple.
- **Access Control:** The `onlyOwner` modifier restricts access to sensitive functions.
- **Immutable State Variables:** Using `immutable` for the AAVE token contract ensures it cannot be changed after deployment, improving security.

## Improvements & Future Work
- **Interest Accrual:** Add interest calculations for liquidity providers.
- **Integration with Aave Protocol:** Integrate this pool with the Aave lending protocol to generate yields.
- **Upgrade Security:** Add reentrancy protection using OpenZeppelin's `ReentrancyGuard`.

## License
This documentation and code should provide you with a strong foundation to build and expand this project. You can start by testing the contract locally using Hardhat and later deploy it to a testnet like Rinkeby or Goerli for further validation.