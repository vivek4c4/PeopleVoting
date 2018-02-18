var Voting = artifacts.require("./Voting.sol");
module.exports = function(deployer) {
  deployer.deploy(Voting, ['Zuckerberg', 'Elon Musk', 'Rock']);
};