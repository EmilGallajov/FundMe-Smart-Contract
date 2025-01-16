# FundMe Smart Contract

The **FundMe-Smart-Contract** project demonstrates the use of Solidity to build a decentralized crowdfunding platform. The smart contract leverages Chainlink oracles for price feeds and includes gas-efficient mechanisms to optimize operations.

## Overview

This project consists of two key components:

1. **PriceConverter Library**: Provides utility functions to fetch ETH price in USD and perform conversions.
2. **FundMe Contract**: Allows users to fund the contract and withdraw funds if they are the owner.

### Features
- Integration with Chainlink price oracles for real-time ETH/USD conversions.
- Use of `constant` and `immutable` keywords for gas optimization.
- Custom error handling using the `error` keyword.
- `receive` and `fallback` functions to handle direct ETH transfers.

---

## Contract Details

### PriceConverter.sol
The **PriceConverter** library includes the following key functions:

- **`getPrice`**: Retrieves the current ETH price in USD from a Chainlink price feed and converts it to 18 decimals.
- **`getConversionRate`**: Converts an input ETH amount to its equivalent USD value.
- **`getVersion`**: Fetches the version of the Chainlink AggregatorV3Interface.

### FundMe.sol
The **FundMe** contract allows users to contribute funds and the owner to withdraw them.

#### Key Variables:
- `MINIMUM_USD`: Minimum funding amount in USD (set to 5 USD).
- `funders`: List of addresses that have contributed.
- `addressToAmountFunded`: Mapping of contributor addresses to their funding amount.
- `i_owner`: Address of the contract owner, set at deployment.

#### Key Functions:
- **`fund`**: Accepts ETH contributions, ensures they meet the minimum threshold, and records the funder.
- **`withdraw`**: Allows only the owner to withdraw all funds and resets the contract state.
- **Modifiers**:
  - `onlyOwner`: Restricts access to owner-only functionality.
- **Fallback Functions**:
  - `receive`: Handles direct ETH transfers.
  - `fallback`: Acts as a fallback mechanism for unexpected calls.

---

## Example Usage

1. **Funding the Contract**:
   Users can call the `fund` function with an ETH amount that meets the minimum USD threshold.
   ```solidity
   fund();
   ```

2. **Withdrawing Funds**:
   The owner can call the `withdraw` function to transfer the contract balance to their address:
   ```solidity
   withdraw();
   ```

3. **Direct ETH Transfers**:
   Users can directly send ETH to the contract, which triggers the `receive` function.

---

## Gas Efficiency

- The use of `constant` and `immutable` reduces gas costs:
  - `MINIMUM_USD`: Defined as a constant.
  - `i_owner`: Defined as immutable, reducing storage access.

---

## Security Considerations

- Ensure proper deployment and testing in a development environment before mainnet deployment.
- Validate Chainlink price feed addresses for the target network.
- Use a secure method to manage the contract owner's private key.

---

## Resources

- [Chainlink Documentation](https://docs.chain.link/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Remix IDE](https://remix.ethereum.org/)
- [Cyrfin Updraft Course](https://updraft.cyfrin.io)

---

## License
This project is licensed under the [MIT License](LICENSE).
