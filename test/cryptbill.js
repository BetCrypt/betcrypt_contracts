import * as globals from './helper_functions/globals.js';
const CryptBill = artifacts.require("./CryptBill.sol");

require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(web3.BigNumber))
  .should();

contract('CryptBill', (accounts) => {

  it("should store correct initialHolder", async () => {
    let cryptBill = await CryptBill.deployed();
    (await cryptBill.initialHolder()).should.be.equal(globals.expectedInitialHolder);
  });

});

