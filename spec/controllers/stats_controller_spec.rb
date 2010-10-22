require 'spec_helper'

describe StatsController do
  include Devise::TestHelpers
  render_views

  def mock_stat(stubs={})
    @mock_stat ||= mock_model(Stat, stubs).as_null_object
  end
#------------------------------------------------#
end

