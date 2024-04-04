# 🏗 Cat vs Dog CTF with ETHChicago, Cyberjam & Scaffold-ETH 2

<h4 align="center">
  <a href="https://docs.scaffoldeth.io">SE-2 Docs</a> |
  <a href="https://www.youtube.com/watch?v=Qu6LKDAfDZI">Cyberjam Recap</a> |
  <a href="https://discord.gg/qe8ETgMskt">ETHChicago Discord</a> 
</h4>

🧪 ZKitty and Tippi Fifestarr hacked together this open-source, update to Patrick Collins'  Star Wars CTF using Scaffold-Eth-2 (a toolkit for building decentralized applications). It's designed to make it easier for developers and security curious attendees at the 2024 CypherCon to create and deploy smart contracts. 

## Quiz contracts
- Easy
  - E1: https://sepolia.etherscan.io/address/0x889aB5BdD6Bf46cbf9AB6a3fa7FF8D6842D541C7
  - E2: https://sepolia.etherscan.io/address/0xFE52f9B9A89b7b5BBA24410D7ebea0482FC8DB1b
- Medium:
  - M1:
  - M2:
- Difficult:
  - H1:

## Original quiz from last year
Original HuntRegistration contract on Sepolia Ethereum testnet is [here](https://sepolia.etherscan.io/address/0xD2Ef69fABB5B95264BFea552BcAD27567ea2C8c3#code).  
1st game address is [here](https://sepolia.etherscan.io/address/0x25154bFa7f78e5898ac038cA98b84F0efD1A406e)

## Interacting with Contracts

**How to Register:** To interact with the contracts, you can use the "debug contracts" function provided in the application. This function allows you to test and interact with the deployed smart contracts.

![Debug Contracts tab](https://github.com/tippi-fifestarr/scaffold-eth-2/assets/62179036/b0b67ea5-bf87-472a-8ba6-5c0369e8b9c7)

## Main Page Features

1. Display Two Teams Image:
   - [x] Display images of the two teams in medium size to represent them visually.
   - [ ] Center a current score counter for each team.

2. Leaderboard:
   - [ ] Display a list of the players leaderboard with the following information:
     - [ ] Ranking #
     - [x] Codename & address
     - [x] Team
     - [ ] Small dynamic NFT image
     - [ ] Score

3. Refresh Button:
   - [ ] Include a refresh button that triggers a read function using the useContractRead hook to fetch the latest scores or leaderboard data.

4. Stretch Goals:
   - [ ] Timer countdown to the end of the game.
   - [ ] Graph the scores over time
   - [ ] Add a "Join Game" button to allow new players to join the game (redirect to debug contracts)



[Scaffold-ETH-2](https://youtu.be/DcOzXhaxtt4?list=PLJz1HruEnenAf80uOfDwBPqaliJkjKg69): ⚙️ Built using NextJS, RainbowKit, Hardhat, Wagmi, Viem, and Typescript.

- ✅ **Contract Hot Reload**: Your frontend auto-adapts to your smart contract as you edit it.
- 🪝 **[Custom hooks](https://docs.scaffoldeth.io/hooks/)**: Collection of React hooks wrapper around [wagmi](https://wagmi.sh/) to simplify interactions with smart contracts with typescript autocompletion.
- 🧱 [**Components**](https://docs.scaffoldeth.io/components/): Collection of common web3 components to quickly build your frontend.
- 🔥 **Burner Wallet & Local Faucet**: Quickly test your application with a burner wallet and local faucet.
- 🔐 **Integration with Wallet Providers**: Connect to different wallet providers and interact with the Ethereum network.

## Requirements

Before you begin, you need to install the following tools:

- [Node (>= v18.17)](https://nodejs.org/en/download/)
- Yarn ([v1](https://classic.yarnpkg.com/en/docs/install/) or [v2+](https://yarnpkg.com/getting-started/install))
- [Git](https://git-scm.com/downloads)

## Quickstart

To get started with Scaffold-ETH 2, follow the steps below:

1. Clone this repo & install dependencies

```
git clone https://github.com/scaffold-eth/scaffold-eth-2.git
cd scaffold-eth-2
yarn install
```

2. Run a local network in the first terminal:

```
yarn chain
```

This command starts a local Ethereum network using Hardhat. The network runs on your local machine and can be used for testing and development. You can customize the network configuration in `hardhat.config.ts`.

3. On a second terminal, deploy the test contract:

```
yarn deploy
```

This command deploys a test smart contract to the local network. The contract is located in `packages/hardhat/contracts` and can be modified to suit your needs. The `yarn deploy` command uses the deploy script located in `packages/hardhat/deploy` to deploy the contract to the network. You can also customize the deploy script.

4. On a third terminal, start your NextJS app:

```
yarn start
```

Visit your app on: `http://localhost:3000`. You can interact with your smart contract using the `Debug Contracts` page. You can tweak the app config in `packages/nextjs/scaffold.config.ts`.

Run smart contract test with `yarn hardhat:test`

- Edit your smart contract `YourContract.sol` in `packages/hardhat/contracts`
- Edit your frontend in `packages/nextjs/pages`
- Edit your deployment scripts in `packages/hardhat/deploy`

## Documentation

Visit our [docs](https://docs.scaffoldeth.io) to learn how to start building with Scaffold-ETH 2.

To know more about its features, check out our [website](https://scaffoldeth.io).

## Contributing to Scaffold-ETH 2

We welcome contributions to Scaffold-ETH 2!

Please see [CONTRIBUTING.MD](https://github.com/scaffold-eth/scaffold-eth-2/blob/main/CONTRIBUTING.md) for more information and guidelines for contributing to Scaffold-ETH 2.
