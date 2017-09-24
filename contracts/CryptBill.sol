//TODO: this is a temporary placeholder token

pragma solidity ^0.4.15;
import 'zeppelin/contracts/token/StandardToken.sol';
import 'zeppelin/contracts/ownership/Ownable.sol';
import './ContractReceiver.sol';

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
    */
  function CryptBill() {
      initialHolder = owner;

      totalSupply = 2000000000 * weiPerEther ; // TODO add this

      // The contract creator will holds all tokens initially
      balances[initialHolder] = totalSupply;
  }

  /** @dev ERC223 transfer function
    * @param _to Address of token receiver.
    * @param _value Number of tokens to transfer.
    * @param _data Data to be sent to tokenFallback
    * @return Returns success of function call.
    */
  function transfer(address _to, uint256 _value, bytes _data)
    public
    returns (bool)
  {
    require(_to != 0x0);
    require(_value > 0);
    require(balances[msg.sender] >= _value);

    balances[msg.sender] -= _value;
    balances[_to] += _value;

    if(isContract(_to)) {
        ContractReceiver receiver = ContractReceiver(_to);
        receiver.tokenFallback(msg.sender, _value, _data);
    }
    TransferERC223(msg.sender, _to, _value, _data);
    return true;
  }

  /** @dev Assemble the given address bytecode. If bytecode exists then the _addr is a contract.
    * @param _addr Address to check
    * @return Returns true if _addr is a contract
    */
  function isContract(address _addr)
    private
    returns (bool)
  {
    uint length;
    assembly {
        //retrieve the size of the code on target address, this needs assembly
        length := extcodesize(_addr)
    }
    return (length > 0);
  }

    event TransferERC223(address indexed _from, address indexed _to, uint256 _value, bytes indexed _data);
}
