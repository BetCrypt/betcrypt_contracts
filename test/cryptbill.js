import * as globals from './helper_functions/globals.js';
const CryptBill = artifacts.require("./CryptBill.sol");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

contract('CryptBill', (accounts) => {

  it("should initialize correctly", async () => {
    let cryptBill = await CryptBill.deployed();
    (await cryptBill.owner()).should.be.equal(accounts[0]);
    ((await cryptBill.totalSupply()).c[0]).should.be.equal(globals.initialAmount);
    (await cryptBill.name()).should.be.equal(globals.tokenName);
    (await cryptBill.symbol()).should.be.equal(globals.tokenSymbol);
    ((await cryptBill.decimals()).c[0]).should.be.equal(globals.decimalUnits);
    ((await cryptBill.balanceOf.call(accounts[0])).c[0]).should.be.equal(globals.initialAmount);
  });

  it("should mint correctly", async () => {
    let cryptBill = await CryptBill.deployed();
    let wei_value = 21000;
    let multiplier = 10**18;
    let mintedTokens = 50 * wei_value;
    await cryptBill.mint({'from': accounts[1], 'value': wei_value});
    
    ((await cryptBill.balanceOf.call(accounts[1])).c[0]).should.be.equal(mintedTokens);

  });

});

