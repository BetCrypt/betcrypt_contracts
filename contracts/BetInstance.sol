pragma solidity ^0.4.15;
import './CryptBill.sol';

contract BetInstance {

  // custom types
  enum BetState {
    NULL,
    Live,
    Payout,
    Ended
  }

  //TODO create modifiers, BetOwnerOnly

  // Array to store the current results (total value) of each bet. Options are
  // indexed same as betResults
  uint[] public betResults;

  // Array that stores the address of all bettors
  address[] public bettors;

  // mapping to store all the text in this bet, populated in constructor
  mapping (uint256 => bytes32) public betText;

  // mapping to store each bettor's total bet value
  mapping (address => uint256) public bets;
  

  // Address of the owner of this bet, this is the entity that called launchBet
  // from BetFactory, betOwner will be responsible for signaling the bet winner.
  address public betOwner;

  // duration of the bet (in relative unix time, since 'now')
  uint public betDuration;
  uint public titleLength;

  /** @dev Constructor
    * @param _betOwner Address of bet instantiator
    * @param _title Title of the bet, array of 32 character bytestrings, max 50 (1600 char max)
    * @param _titleLength Number of 32 character chunks in title.  _title is padded to an array of length 50
    * @param _betOptions Options
    * @param _numberOptions a
    * @param _betDuration a
    */
  function BetInstance(address _betOwner,
                       bytes32[50] _title,
                       uint _titleLength, // _title.length % 32
                       bytes32[50] _betOptions,
                       uint _numberOptions,
                       uint _betDuration)
  {
    betResults.length = _numberOptions;
    titleLength = _titleLength; // number of 32 byte strings
    betOwner = _betOwner;
    betDuration = _betDuration;

    // fill text fields
    // TODO: do this with betText as an array instead of mapping
    uint8 i = 0;
    uint8 j = 0;

    // add title slices first
    while (i < _titleLength)
    {
      betText[i] = _title[i];
      i += 1; //TODO safe math
    }

    // add options after the title
    while (j < _numberOptions)
    {
      betText[i] = _betOptions[j];
      i += 1; //TODO safe math
      j += 1; //TODO safe math
    }

  }

  
  /** @dev Get number of available options
    * @return uint number of available options
    */
  function GetNumberOptions() public constant returns(uint count)
  {
    return betResults.length;

  }


  /** @dev Place a bet, this BetInstance needs to be approved as a spender
           with at least _value before calling PlaceBet()
           TODO: this might be able to handle as a transferFallback (see ERC223)
           TODO: consider uRaiden: https://github.com/raiden-network/microraiden
    * @param _option Option index to bet on
    * @param _value Amount of tokens to bet
    */
  function PlaceBet(uint256 _option, uint256 _value) public
  {
    // transfer funds
    CryptBill bettor = CryptBill(msg.sender);
    bettor.transferFrom(msg.sender, this, _value); // will throw on any funny business

    // update results
    betResults[_option] = betResults[_option] + _value; // TODO: use safemath

    // record bettor address's total bet value
    bettors.push(msg.sender);
    bets[msg.sender] += _value; // TODO: use safemath
  }
}

