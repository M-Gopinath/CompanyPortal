require 'resque-scheduler'
require 'resque/scheduler/server'

if ENV["REDISCLOUD_URL"]
  $redis = Resque.redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
else
  config = ENV.fetch('RAILS_RESQUE_REDIS', '127.0.0.1:6379')
  Resque.redis = config
end

log_file = File.open("#{Rails.root}/log/resque.log", 'w+')
log_file.sync = true
Resque.logger = MonoLogger.new(log_file)
Resque.logger.level = Logger::INFO
