module.exports = function(deployer) {
  deployer.deploy(FundingHub).then(function(){
    // call createProject 
  }).then(function(){
    return deployer.deploy(Project);
  });
};
