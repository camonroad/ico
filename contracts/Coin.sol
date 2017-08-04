pragma solidity ^0.4.11;

import '../zeppelin-solidity/contracts/token/MintableToken.sol';

contract CamToken is MintableToken {
  string public name = "CamToken";
  string public symbol = "CAM";
  uint256 public decimals = 18;
}
