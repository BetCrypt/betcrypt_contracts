pragma solidity ^0.4.15;
import 'zeppelin/contracts/ownership/Ownable.sol';
import './BetInstance.sol';

contract BetFactory is Ownable {

  // dynamically-sized array of created bets
  address[] public bets;
  uint256 public numberBets;

  function BetFactory() {
    numberBets = 0;
  }

  /**
    * @dev Creates a new BetInstance and stores its address.  Currently only the
    *      owner can launch bets.
    * @param _title Title of the bet, should be short and concise to conserve gas
    * @param _betOptions single string with options separated by '\0'
    * @param _numberOptions number of options
    * @param _duration duration of bet (TODO: seconds?)
    */
  function LaunchBet(bytes32[50] _title,
                     uint _titleLength,
                     bytes32[50] _betOptions,
                     uint _numberOptions,
                     uint _duration)
    onlyOwner
    {
      require(_title.length != 0);
      require(_titleLength != 0);
      require(_numberOptions != 0);
      require(_duration != 0);

      // spawn a new bet, store its address
      address new_bet = new BetInstance(msg.sender, _title, _titleLength, _betOptions, _numberOptions, _duration);
      bets.push(new_bet);
      numberBets ++; //TODO safemath
    }
}
