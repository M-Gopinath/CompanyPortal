require 'resque/tasks'
require 'resque/scheduler/tasks'

task 'resque:setup' => :environment do
  require 'resque'
  require 'resque-scheduler'
  schedules = YAML.load_file(Rails.root.join('config', 'resque_schedule.yml'))
  Resque.schedule = schedules unless schedules.nil?
end
