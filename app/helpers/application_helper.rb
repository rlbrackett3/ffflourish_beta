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

  # mark required form fields with an asterix
  def mark_required(object, attribute)
    "*" if object.class.validators_on(attribute).map(&:class).include? ActiveModel::Validations::PresenceValidator
  end

  def user_url(user)
    case user.class.to_s
    when "User"
      user_path(user)
    else
      I18n.t('application.helper.unknown_person')
    end
  end

  # determines where the logo link reqirects users
  def logo_path
    if user_signed_in?
      user_path(current_user)
    else
      root_path
    end
  end

end

