desc " task is called by the Heroku cron add-on"
task :cron => :environment do
  puts "updating mongoDB indexes..."
  Rake::Task['db:create_indexes'].execute
  puts "indexes updated."
  
#  puts "sending daily digest emails..."
#  rake daily_digest:send
#  puts "daily digest emails sent."
end



