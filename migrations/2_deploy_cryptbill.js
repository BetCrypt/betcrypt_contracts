var CryptBill = artifacts.require("./CryptBill.sol");

module.exports = function(deployer) {
  const initialAmount = 12345;
  const tokenName = "CryptBill";
  const decimalUnits = 18;
  const tokenSymbol = "CB";

  deployer.deploy(CryptBill, initialAmount, tokenName, decimalUnits, tokenSymbol);
};
