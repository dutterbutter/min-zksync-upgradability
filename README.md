# min-zksync-upgradability

This repository demonstrates a minimum setup for zkSync contract upgradability using [**foundry-zksync**](https://github.com/matter-labs/foundry-zksync). It includes scripts for deploying and upgrading contracts using the UUPS, Beacon, and Transparent proxy patterns on zkSync.

## Prerequisites

Ensure that you have **foundry-zksync** installed. Follow the installation instructions in the [Foundry-zksync repository](https://github.com/matter-labs/foundry-zksync).

## Getting Started

To get started with this repository, follow the steps below:

### 1. Clone the repository

```bash
git clone git@github.com:dutterbutter/min-zksync-upgradability.git
```

Navigate into the project directory:

```bash
cd min-zksync-upgradability
```

### 2. Install Dependencies

Install the necessary dependencies using `forge`:

```bash
forge install
```

### 3. Build the Project for zkSync

To build the project for zkSync, run:

```bash
forge build --zksync
```

### 4. Private Key Setup with Foundry Keystore

Follow these steps to securely store your wallet's private key to use it in Foundry projects:

- **Extract Your Private Key**: If you're using a local zkSync Era node, use a private key from the available rich accounts. Otherwise, find your personal wallet's private key (e.g., from MetaMask).

- **Create a Foundry Keystore**: Create a keystore and import your private key by running:

    ```bash
    cast wallet import myKeystore --interactive
    ```

    When prompted, enter your private key, provide a password, and copy the returned address (keystore address).

    > Note: The name `myKeystore` is arbitrary and can be changed. If you decide to use another name, ensure consistency when referencing it in commands.

- **Using the Keystore**: When running commands requiring a private key (e.g., `forge create` or `cast send`), use:

    ```bash
    --account myKeystore --sender <KEYSTORE_ADDRESS>
    ```

    You'll need to enter the keystore password during execution.

### 5. Running the Upgrade Scripts

The repository provides scripts to deploy and upgrade contracts using various upgradeability patterns. Execute these scripts using `forge script`:

#### Deploy and Upgrade UUPS Proxy

```bash
forge script script/DeployAndUpgradeUUPSProxy.s.sol:DeployAndUpgradeUUPSProxy --slow --account <YOUR-ACCOUNT-KEYSTORE> --sender <YOUR-SENDER-ADDRESS> --rpc-url ZKsyncSepoliaTestnet --broadcast --zksync -vvvv
```

#### Deploy and Upgrade Transparent Proxy

```bash
forge script script/DeployAndUpgradeTransparentProxy.s.sol:DeployAndUpgradeTransparentProxy --slow --account <YOUR-ACCOUNT-KEYSTORE> --sender <YOUR-SENDER-ADDRESS> --rpc-url ZKsyncSepoliaTestnet --broadcast --zksync -vvvv
```

#### Deploy and Upgrade Beacon Proxy

```bash
forge script script/DeployAndUpgradeBeaconProxy.s.sol:DeployAndUpgradeBeaconProxy --slow --account <YOUR-ACCOUNT-KEYSTORE> --sender <YOUR-SENDER-ADDRESS> --rpc-url ZKsyncSepoliaTestnet --broadcast --zksync -vvvv
```

### 6. Explanation of Flags

- **`--slow`**: This flag sends transactions one at a time, ensuring that they are executed in order, which is critical for upgradable contracts on ZKsync.
  
- **`--zksync`**: Compiles the sources for `zksolc` and automatically switches the execution to the ZKsync context, ensuring compatibility with zkSync Era.

### 7. Broadcasting Transactions on zkSync

To execute the scripts and broadcast transactions correctly on ZKsync, make sure to use the **--slow** and **--zksync** flags to ensure that transactions are processed sequentially and compiled for the ZKsync network.
