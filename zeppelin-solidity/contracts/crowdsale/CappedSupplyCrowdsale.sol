pragma solidity ^0.4.11;

import '../math/SafeMath.sol';
import './Crowdsale.sol';

/**
 * @title CappedSupplyCrowdsale
 * @dev Extension of Crowsdale with a max amount of tokens sold
 */
contract CappedSupplyCrowdsale is Crowdsale {
  using SafeMath for uint256;

  uint256 public capsup;

  function CappedSupplyCrowdsale(uint256 _capsup) {
    require(_capsup > 0);
    capsup = _capsup;
  }

  // overriding Crowdsale#validPurchase to add extra cap logic
  // @return true if investors can buy at the moment
  function validPurchase() internal constant returns (bool) {
    bool withinCapSup = token.totalSupply().add(msg.value * rate) <= capsup;
    return super.validPurchase() && withinCapSup;
  }

  // overriding Crowdsale#hasEnded to add cap logic
  // @return true if crowdsale event has ended
  function hasEnded() public constant returns (bool) {
    bool capSupReached = token.totalSupply() >= capsup;
    return super.hasEnded() || capSupReached;
  }

}
