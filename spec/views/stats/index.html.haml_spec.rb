require 'spec_helper'

describe "stats/index.html.haml" do
  before(:each) do
    assign(:stats, [
      stub_model(Stat),
      stub_model(Stat)
    ])
  end

end
