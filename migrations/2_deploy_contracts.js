var SimpleStorage = artifacts.require("./SimpleStorage.sol");
var Sapphires = artifacts.require("./Sapphires.sol");
module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(Sapphires);
};
