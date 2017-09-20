# BetCrypt Smart Contracts

### Install Dependencies
```bash
# install truffle
sudo npm install -g truffle

# install testrpc (for tests)
sudo npm install -g ethereumjs-testrpc

# install node dependencies
npm install .
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
