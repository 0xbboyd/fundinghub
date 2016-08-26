contract Project {

  struct Record {
    address owner;
    uint fundGoal;
    uint deadline;
  }
  Record record;
  mapping(address => uint) funds;

  function Project(address owner, uint fundGoal, uint deadline) {
    record.owner = owner;
    record.fundGoal = fundGoal;
    record.deadline = deadline;
  }

  function fund(){

  }

  function payout(){

  }

  function refund(){

  }

  function (){
    throw;
  }
}
