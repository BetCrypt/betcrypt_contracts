const BetInstance = artifacts.require("./BetInstance.sol");


module.exports = function(deployer) {

  const betOwner = "0x407d73d8a49eeb85d32cf465507dd71d507100c1";

  const titleList = ["This is a pretty long title, i'm", "able to hold up to 50*32 charac", "ters in a single bytes32[] array", ". Each index should be a string", "of 32 characters, with a maximu", "m of 50 indices"];

  const betOptions = ["1 one", "two", "three", "four", "five", "6, can't do only numbers", "seven"];

  const betDuration = 1337;

  deployer.deploy(BetInstance,
    betOwner,
    titleList,
    titleList.length,
    betOptions,
    betOptions.length,
    betDuration);
};
