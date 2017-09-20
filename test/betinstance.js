import * as globals from './helper_functions/globals.js';

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

const BetInstance = artifacts.require("./BetInstance.sol");

contract('BetInstance', (accounts) => {

  it("should have an address", async () => {
    let betInstance = await BetInstance.deployed();
    betInstance.should.exist;
  });


  it("should store correct betOwner", async () => {
    let betInstance = await BetInstance.deployed();
    (await betInstance.betOwner()).should.be.bignumber.equal(globals.expectedbetOwner);
  });


  it("should store correct bet title", async () => {
    let betInstance = await BetInstance.deployed();

    // check each index of the betText array for the bet title
    for (let [index, val] of (globals.expectedTitle).entries()) {
      var thing = await betInstance.betText(index);
      thing = (web3.toAscii(thing)).replace(/\0/g, ''); // strip null characters '\u0000'
      thing.should.be.equal(globals.expectedTitle[index]);
    }
  });


  it("should store correct bet options", async () => {
    let betInstance = await BetInstance.deployed();

    var titleLength = (await betInstance.titleLength()).c[0];

    // check each index of the betText array for the bet options
    for (let [index, val] of (globals.expectedOptions).entries()) {
      var thing = await betInstance.betText(titleLength + index);
      var stripped_thing = web3.toAscii(thing).replace(/\0/g, ''); // strip null characters '\u0000'
      stripped_thing.should.be.equal(globals.expectedOptions[index]);
    }
  });

});

