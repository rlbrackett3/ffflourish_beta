module ApplicationHelper
  
  def title
    base_title = "ffflourish"                         # Variable assignment
    if @title.nil?                                    # Boolean test for nil
      base_title                                      # Implicit return
    else
      "#{base_title} | #{@title}"                     # String interpolation
    end
  end
  
  def setup_stat(stat)
    returning(stat) do |s|
      s.locations.build if s.locations.empty?
      s.websites.build if s.websites.empty?
    end
  end
  
  def user_url(user)
    case user.class.to_s
    when "User"
      user_path(user)
    else
      I18n.t('application.helper.unknown_person')
    end
  end
  
end
