require 'rufus-scheduler'
require 'dotenv/load'
require_relative 'methods'

ENV['TZ'] = 'America/New_York'
scheduler = Rufus::Scheduler.new()

scheduler.cron '56 23 * * *' do
  puts "Running at #{Time.now}"
  x = Methods.new
  x.send_update
end

scheduler.cron '30 9 * * *' do
  x = Methods.new
  x.send_update
end

scheduler.cron '30 14 * * *' do
  x = Methods.new
  x.send_update
end

scheduler.join
