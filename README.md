# 🤝 ETHForwardWithUSDC – Smart Contract Forward Agreement using FakeUSDC

This project demonstrates a blockchain-based **forward contract** between two parties — a buyer and a seller — to exchange Ether for a stablecoin (FakeUSDC) at a predetermined price and future date.

It consists of:
- 🪙 `FakeUSDC.sol` – A mock ERC-20 USDC token
- 📜 `ETHForwardWithUSDC.sol` – A forward contract to exchange ETH and USDC with deposit, settlement, and mutual rejection logic

---

## 📦 Smart Contracts

### 1. `FakeUSDC.sol`
A minimal ERC-20-like token with 6 decimals that simulates a USDC stablecoin, used for testing.

**Features:**
- `transfer`, `transferFrom`, `approve` for basic token operations
- 6 decimal points to simulate USDC's precision
- Deployed by seller or any user with an initial supply

---

### 2. `ETHForwardWithUSDC.sol`
Implements a simple forward contract:
- Seller deposits ETH into the contract
- Buyer pays in USDC at the settlement date to receive the ETH
- Both parties can mutually reject the contract before the settlement date

**Core Functions:**
- `depositEther()` – Seller deposits ETH
- `executeForward()` – Buyer pays USDC, receives ETH if date is valid
- `rejectContract()` – Buyer and seller can cancel the deal before maturity
- `getContractDetails()` – View contract metadata

---

## 🚀 Deployment (Remix IDE)

1. Open [Remix IDE](https://remix.ethereum.org/)
2. Create two files:
   - `FakeUSDC.sol`
   - `ETHForwardWithUSDC.sol`
3. Compile both using Solidity `^0.8.18`
4. Deploy `FakeUSDC` with an initial supply (e.g., `1000000000` for 1000 USDC)
5. Deploy `ETHForwardWithUSDC` with:
   - `buyer` address
   - `seller` address
   - `usdcToken` address (from step 4)
   - `strikePrice` (in USDC units, e.g., 2000 USDC = `2000000000`)
   - `ethAmount` (in wei, e.g., 1 ETH = `1000000000000000000`)
   - `settlementDate` (Unix timestamp)
6. From  seller's account, he will call depositEther() with 1 ETH.

7. Then from Buyer's account,he will call approve(forward_contract_address, 2000000000) on FakeUSDC.

8. After settlemetDate(60 seconds), Buyer can call executeForward() from His account to execute the contract.



---

## 🧪 Testing

You can test via Remix with multiple accounts (e.g., seller deposits ETH, buyer executes forward):

- ✅ Seller deposits exact ETH using `depositEther()`
- ✅ Buyer executes forward via `executeForward()` after the settlement date
- ✅ Both buyer and seller can cancel early via `rejectContract()`
- ❌ Early execution or one-sided rejection is blocked

---

## 📚 Use Cases

- Educational demonstration of Ethereum-based derivatives
- OTC peer-to-peer smart contract agreements
- Prototype for decentralized finance contracts involving stablecoins and ETH

---

## 📌 Technologies Used

- **Solidity** 0.8.18
- **Remix IDE**
- **Ethereum Virtual Machine (EVM)**
- **Fake ERC-20 (USDC) token**

---

## 🔐 License

This project is licensed under the **MIT License** — feel free to use and modify!

---

## ✍️ Author

**Prem Dubay**  
Blockchain Developer Intern  
ABC Engineering College

---

