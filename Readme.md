# Digital Rights Management (DRM) System

A decentralized Digital Rights Management system built on Ethereum blockchain that allows content creators to manage and monetize their digital content through smart contracts.

## Overview

This DRM system enables content creators to:
- Register and manage digital content
- Set pricing for content access
- Issue time-limited licenses to users
- Monitor content usage and access rights

Users can:
- Purchase licenses for content
- Access content with valid licenses
- View their license details and validity

## Technology Stack

- **Smart Contract**: Solidity ^0.8.0
- **Frontend**: HTML, CSS, JavaScript
- **Web3 Integration**: Web3.js
- **Wallet**: MetaMask
- **Network**: Ethereum (supports any EVM-compatible network)

## Prerequisites

- Node.js and npm installed
- MetaMask browser extension
- An Ethereum wallet with test/real ETH for deploying contracts and purchasing licenses

## Installation

1. Clone the repository:
```bash
git clone [repository-url]
cd drm-system
```

2. Install dependencies:
```bash
npm install
```

3. Deploy the smart contract:
   - Use Remix IDE or Truffle/Hardhat
   - Save the deployed contract address
   - Update the contract address in `index.html`

4. Serve the frontend:
```bash
# Using any HTTP server, e.g., python
python -m http.server 8000
```

## Smart Contract Details
Contract address: '0x9f4c5943DFB74eD4CE74Fe4888155228c9C8Bd66'
### Key Structures

```solidity
struct Content {
    address creator;
    string contentHash;
    uint256 price;
    bool isActive;
}

struct License {
    bool isValid;
    uint256 purchaseDate;
    uint256 expiryDate;
}
```

### Main Functions

1. `registerContent(string memory contentHash, uint256 price)`
   - Registers new content with specified hash and price
   - Returns unique content ID

2. `purchaseLicense(uint256 contentId, uint256 duration)`
   - Purchases time-limited license for content
   - Requires payment equal to content price

3. `hasValidLicense(uint256 contentId, address user)`
   - Checks if user has valid license for content

4. `getContent(uint256 contentId)`
   - Retrieves content hash if user has valid license

5. `deactivateContent(uint256 contentId)`
   - Allows creator to deactivate their content

## Frontend Features

### User Interface Components

1. Wallet Connection
   - Automatic MetaMask integration
   - Displays connected wallet address
   - Connection status indicator

2. Content Registration
   - Input for content hash
   - Price setting in ETH
   - Registration confirmation

3. License Management
   - License purchase interface
   - Duration selection
   - Payment handling

4. Content Access
   - Content ID lookup
   - License validity checking
   - Content deactivation for creators

## Usage Guide

### For Content Creators

1. Connect your MetaMask wallet
2. Navigate to "Register Content" section
3. Enter content hash (e.g., IPFS hash)
4. Set price in EDU
5. Submit transaction through MetaMask

### For Users

1. Connect your MetaMask wallet
2. Find desired content ID
3. Navigate to "Purchase License" section
4. Enter content ID and desired duration
5. Complete purchase transaction
6. Access content using "Check Content" function

## Security Considerations

- All transactions require MetaMask confirmation
- Content access is restricted to license holders
- License validity is time-based
- Only creators can deactivate their content
- Smart contract includes required checks and modifiers

## Development and Testing

1. Local Testing:
   - Use Ganache for local blockchain
   - Deploy contract to test network
   - Use test accounts from MetaMask

2. Smart Contract Testing:
   - Test all functions
   - Verify license validity
   - Check access controls
   - Test payment handling

## Error Handling

The system includes comprehensive error handling for:
- Invalid transactions
- Insufficient payments
- Expired licenses
- Unauthorized access attempts
- Network issues
- Wallet connection problems

## Future Enhancements

Potential improvements:
1. License renewal functionality
2. Bulk license purchases
3. Royalty distribution system
4. Content metadata storage
5. License transfer between users
6. Content preview functionality
7. Advanced analytics dashboard



## Disclaimer

This is a basic implementation of DRM and should be enhanced with additional security measures for production use.