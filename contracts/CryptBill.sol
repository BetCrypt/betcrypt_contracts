/*
 * ERC223 compilant (ERC20 backwards compatible):
 * https://github.com/ethereum/EIPs/issues/223
 *
 * NOTE: https://medium.com/@weka/dividend-bearing-tokens-on-ethereum-42d01c710657
 */

pragma solidity ^0.4.15;
import '../microraiden/contracts/contracts/Token/StandardToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';
//import 'zeppelin-solidity/contracts/token/StandardToken.sol';

contract CryptBill is StandardToken, Ownable {

  // constants
  uint256 constant weiPerEther = 1e18;
  uint256 constant cbPerEther = 1; // TODO add this

  uint256 multiplier;

  event Mint(address indexed _from, uint256 indexed _num, uint256 _value);

  // token attributes
  //string public constant name = "CryptBill";
  //string public constant symbol = "CB";
  //uint8 public constant decimals = 18;

  // important addresses
  address public initialHolder;

  /** @dev Constructor
    * @param _initialAmount Initial amount of tokens - in smallest unit
    * @param _tokenName Token name
    * @param _decimalUnits Amount of decimals in token
    * @param _tokenSymbol Token's short form
    */
  function CryptBill(
    uint256 _initialAmount,
    string _tokenName,
    uint8 _decimalUnits,
    string _tokenSymbol
    )
  {
    multiplier = 10**(uint256(_decimalUnits));
    balances[owner] = _initialAmount;  // Give the creator all initial tokens
    totalSupply = _initialAmount;      // Update total supply
    name = _tokenName;                 // Set the name for display purposes
    decimals = _decimalUnits;          // Amount of decimals for display purposes
    symbol = _tokenSymbol;             // Set the symbol for display purposes
  }


  /** @dev Mint tokens, create and allocate to sender.  ETH must be attached.
    */
  function mint()
    public
    payable
  {
    require(msg.value >= 1000 wei);  // adjust this

    uint256 num = uint256(msg.value) * 50;

    // TODO safemath
    totalSupply += num;
    balances[msg.sender] += num;

    Mint(msg.sender, num, msg.value);
  }
}
