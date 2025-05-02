require 'rufus-scheduler'
require_relative 'methods'

# Initialize the scheduler
scheduler = Rufus::Scheduler.new

# Schedule the task to run every day at midnight
scheduler.cron '30 20 * * *' do
  x = Methods.new
  # x.send_update
  x.send_update
end

scheduler.cron '30 9 * * *' do
  x = Methods.new
  x.send_update
end

# Keep the script running
scheduler.join
