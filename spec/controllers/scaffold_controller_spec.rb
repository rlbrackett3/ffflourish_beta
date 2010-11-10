require 'spec_helper'

describe ScaffoldController do

  describe "GET 'posts'" do
    it "should be successful" do
      get 'posts'
      response.should be_success
    end
  end

end
