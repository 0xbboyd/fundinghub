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

  function fund(){
    if(campaign.paidOut || now > campaign.deadline || msg.value == 0) throw;
    uint amount = msg.value;
    contributions[msg.sender] = amount;
    fundTotal += amount;
  }

  function payout(){
    if(campaign.paidOut || now < campaign.deadline || campaign.fundTotal < campaign.fundGoal) throw;
    if(msg.sender != campaign.owner) throw;

    campaign.paidOut = true;
    uint amount = campaign.fundTotal;
    campaign.fundTotal = 0;

    if(!campaign.owner.send(amount)){
      campaign.paidOut = false;
      campaign.fundTotal = amount;
    }
  }

  function refund(address contributor){
    if(campaign.paidOut || now < deadline) throw;
    if(msg.sender != contributor) throw;

    uint amount = contributions[contributor];
    contributions[contributor] -= amount;

    if(!contributor.send(amount)){
      contributions[contributor] += amount;
    }
  }

  function (){
    throw;
  }
}
