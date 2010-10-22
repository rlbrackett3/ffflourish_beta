require 'spec_helper'

describe "stats/edit.html.haml" do
  before(:each) do
    @stat = assign(:stat, stub_model(Stat,
      :new_record? => false
    ))
  end

end
