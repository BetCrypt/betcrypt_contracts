//TODO: this is a temporary placeholder token

pragma solidity ^0.4.15;
import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract CryptBill is StandardToken, Ownable {
  // TODO: https://medium.com/@weka/dividend-bearing-tokens-on-ethereum-42d01c710657

  // constants
  uint256 constant weiPerEther = 1e18;
  uint256 constant cbPerEther = 1; // TODO add this

  // token attributes
  string public constant name = "CryptBill";
  string public constant symbol = "CB";
  uint8 public constant decimals = 18;

  // important addresses
  address public initialHolder;

  /** @dev Constructor
    * @param _initialHolder address of initial CB holder
    */
  function CryptBill(address _initialHolder) {
      initialHolder = _initialHolder;

      totalSupply = 2000000000 * weiPerEther ; // TODO add this

      // The contract creator will holds all tokens initially
      balances[initialHolder] = totalSupply;
  }
}
