# BetCrypt Smart Contracts

[![Build Status](https://travis-ci.org/BetCrypt/betcrypt_contracts.svg?branch=master)](https://travis-ci.org/BetCrypt/betcrypt_contracts)

### Install Dependencies
```bash
# install truffle and smart contract packages
npm install -g truffle
npm install zeppelin-solidity
npm install -g web3

# install testrpc (for tests)
npm install -g ethereumjs-testrpc

# install packages for test dependencies
npm install babel-register --save-dev
npm install babel-preset-env --save-dev
npm install --save babel-polyfill
npm install chai
npm install chai-as-promised
npm install --save-dev chai-bignumber

```

### Run Tests
```bash
# start testrpc in one shell
testrpc

# run tests in another shell
truffle test
```

### Clean build smart contracts
```bash
# with testrpc running in another shell
truffle compile
truffle migrate --reset
```
