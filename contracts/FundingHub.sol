import "./Project.sol";

contract FundingHub {
  mapping(address => Project) register;

  function FundingHub() {
    // constructor
  }

  function createProject(address owner, uint fundGoal, uint deadline) return (address project){
    Project newProject = Project(owner, fundGoal, deadline);
    register[newProject.address] = newProject;
    return newProject.address;
  }

  function contribute(address project){
    if(msg.value == 0) throw;
    register[project].fund(msg.value);
  }

  function (){
    throw;
  }
}
