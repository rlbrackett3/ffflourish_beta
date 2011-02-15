namespace :daily_digest do
  desc "send daily digest email"
  task :send => :environment do
    User.all.each do |u|
      DailyDigest.digest(u).deliver
    end
  end
end
