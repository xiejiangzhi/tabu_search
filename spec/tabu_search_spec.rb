require "spec_helper"

RSpec.describe TabuSearch do
  it "has a version number" do
    expect(TabuSearch::VERSION).not_to be nil
  end

  it "should define tabu_search method" do
    expect(TestUnit.methods).to be_include(:tabu_search)
  end

  it "should define new_ts_ctx method" do
    expect(TestUnit.methods).to be_include(:new_ts_ctx)
  end
end
