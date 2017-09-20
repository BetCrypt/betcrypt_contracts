import * as globals from './helper_functions/globals.js';

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

const BetFactory = artifacts.require("./BetFactory.sol");

contract('BetFactory', (accounts) => {

  it("should initialize correctly", async() => {
    let betFactory = await BetFactory.deployed();

    (await betFactory.owner()).should.be.equal(accounts[0]);
    ((await betFactory.numberBets()).c[0]).should.be.equal(0);
  });

  it("should launch bet correctly", async() => {
    let betFactory = await BetFactory.deployed();

    await betFactory.LaunchBet(
      globals.expectedTitleForFactoryTest,
      globals.expectedTitleForFactoryTest.length,
      globals.expectedOptions,
      globals.expectedOptions.length,
      globals.duration);

    ((await betFactory.numberBets()).c[0]).should.be.equal(1);
  });
  

});
