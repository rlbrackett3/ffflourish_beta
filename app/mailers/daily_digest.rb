class DailyDigest < ActionMailer::Base
  default :from => "info@ffflourish.com"
  
  def digest(user)
    @user = user
    @following_link = user_following_url(user)
    
    mail(
    :to => @user.email,
    :subject => "#{@user.profile.name}'s daily ffflourish digest"
    )
    
  end
  
end
