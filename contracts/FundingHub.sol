import "./Project.sol";

contract FundingHub {
  mapping(address => Project) register;

  function FundingHub() {
    // constructor
  }

  function createProject(address owner, uint fundGoal, uint deadline) returns (address project){
    Project newProject = new Project(owner, fundGoal, deadline);
    address projAddress = newProject.getAddress();
    register[projAddress] = newProject;
    return projAddress;
  }

  function contribute(address project) returns (bool){
    if(msg.value == 0) return false;
    bool success = register[project].fund.value(msg.value);
    if(!success) {
      if(!msg.sender.send(msg.value)) throw;
    }
    return success;
  }

  function (){
    throw;
  }
}
