pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/CryptBill.sol";

contract TestCryptBill {
  // constants
  uint256 constant WEI_PER_ETHER = 1e18;

  /**
    * @dev Test that initial balance is correct using deployed contract
    */
  function testInitialBalanceUsingDeployedContract() {
    CryptBill cb = CryptBill(DeployedAddresses.CryptBill());

    uint expected = 2000000000 * WEI_PER_ETHER ; // TODO match with CryptBill.sol

    Assert.equal(cb.balanceOf(cb.initialHolder()), expected,
                 "Owner should have 2000000000e18 CryptBill initially");
  }


  /**
    * @dev Test that initial balance is correct using new contract
    */
  function testInitialBalanceWithNewCryptBill() {
    CryptBill cb = new CryptBill(tx.origin);

    uint expected = 2000000000 * WEI_PER_ETHER ; // TODO match with CryptBill.sol

    Assert.equal(cb.balanceOf(cb.initialHolder()), expected,
                 "Owner should have 2000000000e18 CryptBill initially");
  }

}
