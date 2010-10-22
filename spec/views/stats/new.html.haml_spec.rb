require 'spec_helper'

describe "stats/new.html.haml" do
  before(:each) do
    assign(:stat, stub_model(Stat,
      :new_record? => true
    ))
  end

end
