contract('Project', function(accounts) {
  it("should assert true", function(done) {
    var project = Project.at(Project.deployed_address);
    assert.isTrue(true);
    done();
  });
});
