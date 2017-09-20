var CryptBill = artifacts.require("./CryptBill.sol");

module.exports = function(deployer) {
  const expectedInitialHolder = "0x407d73d8a49eeb85d32cf465507dd71d507100c1";

  deployer.deploy(CryptBill, expectedInitialHolder);
};
