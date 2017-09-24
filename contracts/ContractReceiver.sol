pragma solidity ^0.4.15;
import 'zeppelin/contracts/ownership/Ownable.sol';

contract ContractReceiver is Ownable {

  /** @dev Function that is called when a user or another contract wants to transfer
    *      funds. Based on microraiden implementation
    * @param _from Transaction initiator, analogue of msg.sender
    * @param _value Number of tokens to transfer.
    * @param _data Data containing a function signature and/or parameters
    */
  function tokenFallback(address _from, uint256 _value, bytes _data);
}
