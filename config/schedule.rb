# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#set :output, {:error => "#{Dir.pwd}/logs/stderr.log", :standard => "#{Dir.pwd}/logs/stdout.log"}
set :output, "#{Dir.pwd}/logs/cron.log"
#every 10.minutes

job_type :rake, "cd :path && RAILS_ENV=:environment rake :task --silent :output"
every 6.hours do
 rake 'fetch'
end
