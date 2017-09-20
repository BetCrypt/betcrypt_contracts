pragma solidity ^0.4.15;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/BetFactory.sol";

contract TestBetFactory {
    address expectedbetOwner = tx.origin;

    bytes32[50] expectedTitle;
    bytes32[50] expectedOptions;

    // ugly yes, but there's no inline array initialization yet, so we use the
    // literal in beforeAll().  These are the lengths of those literals.
    uint256 numberTitleSlices = 6;     
    uint256 numberOptions = 8;

    uint256 betDuration = 90061; // 1 day 1 hr 1 min 1 sec
  

  /**
    * @dev Runs before all tests - initialize test variables
    */
  function beforeAll() {
    // can't inline initialize arrays yet...so this must be done
    expectedTitle[0] = "is test for bet factory, i'm";
    expectedTitle[1] = "able to hold up to 50*32 charac";
    expectedTitle[2] = "ters in a single bytes32[] array";
    expectedTitle[3] = ". Each index should be a string";
    expectedTitle[4] =  "of 32 characters, with a maximu";
    expectedTitle[5] =  "m of 50 indices";

    expectedOptions[0] = "1 one test";
    expectedOptions[1] = "two";
    expectedOptions[2] = "three";
    expectedOptions[3] = "four";
    expectedOptions[4] = "five";
    expectedOptions[5] =  "6, can't do only numbers";
    expectedOptions[6] =  "seven";
    expectedOptions[7] =  "eight";

  }


  /**
    * @dev Test that initial values are set correctly on deployment
    */
  function testInitialValuesSet() {
    BetFactory bf = BetFactory(DeployedAddresses.BetFactory());
    
    Assert.equal(bf.owner(), tx.origin, "owner initialized incorrectly");
    Assert.equal(bf.numberBets(), 0, "bet counter not initialized correctly");
  }

  
  /**
    * @dev Test that LaunchBet() creates a properly initialized BetInstance
    */
  function testLaunchBet() {
    // BetFactory bf = BetFactory(DeployedAddresses.BetFactory());
    BetFactory bf = new BetFactory();
    
    bf.LaunchBet(expectedTitle, numberTitleSlices, expectedOptions, numberOptions, betDuration);

    Assert.equal(bf.numberBets(), 1, "bet counter not incremented correctly");

    address betInstanceAddress = bf.bets(0);
    BetInstance bi = BetInstance(betInstanceAddress);

    Assert.equal(bi.betOwner(), this, "betOwner initialized incorrectly");
    Assert.equal(bi.betText(0), expectedTitle[0],
                 "title[0] initialized incorrectly");
    Assert.equal(bi.betText(1), expectedTitle[1],
                 "title[1] initialized incorrectly");
    Assert.equal(bi.betText(2), expectedTitle[2],
                 "title[2] initialized incorrectly");
    Assert.equal(bi.betText(3), expectedTitle[3],
                 "title[3] initialized incorrectly");
    Assert.equal(bi.betText(4), expectedTitle[4],
                 "title[4] initialized incorrectly");
    Assert.equal(bi.betText(5), expectedTitle[5],
                 "title[5] initialized incorrectly");
    Assert.equal(bi.betText(6), expectedOptions[0],
                 "betOptions[0] initialized incorrectly");
    Assert.equal(bi.betText(7), expectedOptions[1],
                 "betOptions[1] initialized incorrectly");
    Assert.equal(bi.betText(8), expectedOptions[2],
                 "betOptions[2] initialized incorrectly");
    Assert.equal(bi.betText(9), expectedOptions[3],
                 "betOptions[3] initialized incorrectly");
    Assert.equal(bi.betText(10), expectedOptions[4],
                 "betOptions[4] initialized incorrectly");
    Assert.equal(bi.betText(11), expectedOptions[5],
                 "betOptions[5] initialized incorrectly");
    Assert.equal(bi.betText(12), expectedOptions[6],
                 "betOptions[6] initialized incorrectly");
    Assert.equal(bi.betText(13), expectedOptions[7],
                 "betOptions[7] initialized incorrectly");
    Assert.equal(bi.GetNumberOptions(), numberOptions,
                 "numberOptions initialized incorrectly");
    Assert.equal(bi.betDuration(), betDuration,
                 "betDuration initialized incorrectly");

  }

}
