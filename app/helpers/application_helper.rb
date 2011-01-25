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

  # setting for the jquery.pageless endless page lugin
  def pageless(total_pages, url=nil, container=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => 'Loading more results',
      :distance   => 2000
    }

    container && opts[:container] ||= container

    javascript_tag("$('#results').pageless(#{opts.to_json});")
  end

  class Time
    def self.random(years_back=1)
      year = Time.now.year - rand(years_back) - 1
      month = rand(12) + 1
      day = rand(31) + 1
      Time.local(year, month, day)
    end
  end


end

