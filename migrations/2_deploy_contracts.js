module.exports = function(deployer) {
  // deployer.deploy(Project);
  deployer.deploy(FundingHub).then(function(instance){
    return FundingHub.deployed().address;
  }).then(function(hubAddress){
    var hub = FundingHub.at(hubAddress);
    return hub.createProject(web3.eth.accounts[0], 100000, new Date(new Date().setMonth(new Date().getMonth()+6)));
  });
};
