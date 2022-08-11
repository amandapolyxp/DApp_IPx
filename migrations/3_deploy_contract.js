var TicketContract = artifacts.require("./TicketContract.sol");

module.exports = function(deployer) {
  deployer.deploy(TicketContract);
};