var CamOnRoadCrowdsale = artifacts.require("./CamOnRoadCrowdsale.sol")

module.exports = function(deployer, network, accounts) {
  const startTime = 1507831200 // Timestamp when the crowdsale will start. 12 Oct 2017 21:00:00 MSK
  const preIcoEndTime = 1508054400 // Timestamp when pre ICO will end. 15 Oct 2017 11:00:00 MSK
  const endTime = 1510732800  // Timestamp when crowdsale will end. 15 Nov 11:00:00 MSK
  const rate = new web3.BigNumber(800) // rate of token in ETH. send X eth - get X*rate tokens
  const mininvest = new web3.BigNumber(50) // minimal pay avaliable in finney. Finney is 1/1000 ether
  const ownerWallet = "0x00d3Fdb9e99079C1d1Ea01463f179Ec846C23D9A" // the address that will hold tokens and will manage contract
  const beneficiaryWallet = "0x85312BCA18B08c8349F3e1f87494aAFD51e51bE2" // multisig address that will hold money (not tokens)
  const goal = new web3.BigNumber(10000) // crowdsale goal.
  const preIcoCap = new web3.BigNumber(125) // crowdsale ICO cap. Max pre-ico inverstors can buy until preico ends (see preIcoEndBlock param). Currently in finney
  const tokensTotal = new web3.BigNumber(10000000) // How much token we must have at ALL.
  const tokensForSale = new web3.BigNumber(6500000) // How much token we should sale.
  const tokensForTeam = new web3.BigNumber(2500000) // How much token we'll reserve for team. token will be locked in vault.
  deployer.deploy(CamOnRoadCrowdsale,
                  startTime,
                  preIcoEndTime,
                  endTime,
                  rate,
                  web3.toWei(mininvest, "finney"),
                  ownerWallet,
                  beneficiaryWallet,
                  web3.toWei(goal, "ether"),
                  web3.toWei(preIcoCap, "ether"),
                  web3.toWei(tokensTotal, "ether"),
                  web3.toWei(tokensForSale, "ether"),
                  web3.toWei(tokensForTeam, "ether")
                )
}
