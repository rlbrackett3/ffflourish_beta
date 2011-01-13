module ApplicationHelper
  #--Page Titles--#
  def title
    base_title = "ffflourish"                         # Variable assignment
    if @title.nil?                                    # Boolean test for nil
      base_title                                      # Implicit return
    else
      "#{base_title} | #{@title}"                     # String interpolation
    end
  end
  #--Making text pluralized--#
  def make_this_plural(number, text)
    return text.pluralize if number != 1
    text
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

  def logo_path
    if user_signed_in?
      user_path(current_user)
    else
      root_path
    end
  end

end

