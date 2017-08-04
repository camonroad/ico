pragma solidity ^0.4.11;

import './Coin.sol';
import '../zeppelin-solidity/contracts/crowdsale/CappedSupplyCrowdsale.sol';
import '../zeppelin-solidity/contracts/crowdsale/RefundableCrowdsale.sol';
import '../zeppelin-solidity/contracts/token/TokenTimelock.sol';


contract CamCoinCrowdsale is CappedSupplyCrowdsale, RefundableCrowdsale {

    uint256 private tokensTotal;
    uint256 private tokensForTeam;
    uint256 public mininvest;
    uint256 private current;
    uint256 public preIcoEndBlock;
    uint256 private preIcoCap;
    address public wallet;
    address private owner;
    address public timeVault;


    function CamCoinCrowdsale(uint256 _startBlock, uint256 _preIcoEndBlock, uint256 _endBlock, uint256 _rate, uint256 _mininvest, address _ownerWallet, address _beneficiaryWallet, uint256 _goal, uint256 _preIcoCap, uint256 _tokensTotal, uint256 _tokensForSale, uint256 _tokensForTeam)
    CappedSupplyCrowdsale(_tokensForSale)
    RefundableCrowdsale(_goal)
    Crowdsale(_startBlock, _endBlock, _rate, _beneficiaryWallet) {
        owner = _ownerWallet;
        wallet = _beneficiaryWallet;
        require(_goal > 0);
        require(_preIcoCap > 0);
        require(_mininvest > 0);
        require (_tokensForTeam + _tokensForSale < _tokensTotal);
        require(_startBlock < _preIcoEndBlock);
        require(_preIcoEndBlock < _endBlock);
        tokensTotal = _tokensTotal;
        tokensForTeam = _tokensForTeam;
        mininvest = _mininvest;
        preIcoCap = _preIcoCap;
        preIcoEndBlock = _preIcoEndBlock;

        timeVault = new TokenTimelock(token, owner, now + 548 days);

    }

    function createTokenContract() internal returns (MintableToken) {
        return new CamToken();
    }

    function validPurchase() internal constant returns (bool) {
        require (msg.value > mininvest);
        if (block.number <= preIcoEndBlock) {
            require(weiRaised.add(msg.value) <= preIcoCap);
        }
        return super.validPurchase();
    }

    function finalization() internal onlyOwner {
        current = tokensTotal - (token.totalSupply() + tokensForTeam);

        token.mint(timeVault, tokensForTeam);
        token.mint(owner, current);
        super.finalization();
        token.transferOwnership(owner);
    }

    function setRate(uint256 _rate) public onlyOwner {
        require(_rate > 0);
        rate = _rate;
    }

}
