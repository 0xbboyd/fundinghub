contract Project {
  struct Campaign {
    address owner;
    uint fundGoal;
    uint deadline;
    uint fundTotal;
    bool paidOut;
  }
  Campaign campaign;
  mapping(address => uint) contributions;

  function Project(address owner, uint fundGoal, uint deadline) {
    campaign.owner = owner;
    campaign.fundGoal = fundGoal;
    campaign.deadline = deadline;
  }

  function fund() returns (bool success){
    if(campaign.paidOut || now > campaign.deadline || msg.value == 0) return false;
    uint amount = msg.value;
    contributions[msg.sender] = amount;
    campaign.fundTotal += amount;
    return true;
  }

  function payout() returns (bool success){
    if(campaign.paidOut || now < campaign.deadline || campaign.fundTotal < campaign.fundGoal) return false;
    if(msg.sender != campaign.owner) return false;

    campaign.paidOut = true;
    uint amount = campaign.fundTotal;
    campaign.fundTotal = 0;

    if(!campaign.owner.send(amount)){
      campaign.paidOut = false;
      campaign.fundTotal = amount;
      return false;
    }
    return true;
  }

  function refund(address contributor) returns (bool success){
    if(campaign.paidOut || now < campaign.deadline) return false;
    if(msg.sender != contributor) return false;

    uint amount = contributions[contributor];
    contributions[contributor] -= amount;
    campaign.fundTotal -= amount;

    if(!contributor.send(amount)){
      contributions[contributor] += amount;
      campaign.fundTotal += amount;
      return false;
    }
    return true;
  }

  function getAddress() returns (address){
    return this;
  }

  function (){
    throw;
  }
}
