var Lotto = artifacts.require("./contracts/lotto.sol");

module.exports = function (deployer) {
  deployer.deploy(Lotto);
}

