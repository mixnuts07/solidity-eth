const GreeterContract = artifacts.require("Greeter");

module.exports = function (_deployer) {
  // Use deployer to state migration tasks.
  _deployer.deploy(GreeterContract);
};
