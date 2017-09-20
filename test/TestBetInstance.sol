pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BetInstance.sol";

contract TestBetInstance {

  bytes32[50] title; // = new bytes32[](50);
  bytes32[50] betOptions; // = new bytes32[](50);
  uint8 titleLength = 2;
  uint8 numberOptions = 3;

  // test 
  address betOwner = 0x12345;
  uint256 betDuration = 90061; // 1 day 1 hr 1 min 1 sec



  /**
    * @dev Test that initial values are set correctly on deployment
    */
  function testInitialValuesSet() {

    title[0] = "abcdefghijklmnopqrstuvwxyzabcd";
    title[1] = "bet title";
    betOptions[0] = "one";
    betOptions[1] = "two";
    betOptions[2] = "three";

    BetInstance bi = new BetInstance(betOwner,
                                     title,
                                     titleLength,
                                     betOptions,
                                     numberOptions,
                                     betDuration);

    Assert.equal(bi.betOwner(), betOwner, "betOwner initialized incorrectly");
    Assert.equal(bi.betText(0), title[0], "title[0] initialized incorrectly");
    Assert.equal(bi.betText(1), title[1], "title[1] initialized incorrectly");
    Assert.equal(bi.betText(2), betOptions[0],
                 "betOptions[0] initialized incorrectly");
    Assert.equal(bi.betText(3), betOptions[1],
                 "betOptions[1] initialized incorrectly");
    Assert.equal(bi.betText(4), betOptions[2],
                 "betOptions[2] initialized incorrectly");
    Assert.equal(bi.GetNumberOptions(), numberOptions,
                 "numberOptions initialized incorrectly");
    Assert.equal(bi.betDuration(), betDuration,
                 "betDuration initialized incorrectly");

  }

}
