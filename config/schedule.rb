set :output, "./log/cron_log.log"

every 30.minutes do
  rake "twitterbot"
end
