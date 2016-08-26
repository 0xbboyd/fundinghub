contract('Project', function(accounts) {
  web3 = require('../lib/transactionReceipt')(web3);
  it("should not refund before the campaign ends", function(done) {
    // var project = Project.new(web3.eth.accounts[0], 1, new Date(new Date().setMonth(new Date().getMonth()+6)));

    done();
  });

  it("should not refund if the campaign has paid out", function(done){
    done();
  });

  it("should not refund if the requestor is different than the contributor", function(done){
    done();
  });

  it("should refund my funds", function(done){
    var coinbase = web3.eth.accounts[0];
    var amount = 1;
    var project = Project.new(coinbase, amount, new Date());
    var startAmount = web3.eth.getBalance(coinbase);

    project.fund({from:coinbase, value:amount}).then(function(tx){
      return getTransactionReceiptMined(tx);
    }).then(function(receipt){
      var postFund = web3.eth.getBalance(coinbase);
      assert.equal(startAmount, postFund + amount, "funding did not transfer correctly");
    }).then(function(){
      return project.refund(coinbase);
    }).then(function(tx){
      return getTransactionReceiptMined(tx);
    }).then(function(receipt){
      // check balances;
    });
  });
});
