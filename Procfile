# NOTE!! For this to work you need to enable the log-runtime-metrics beta feature on Heroku
# See https://devcenter.heroku.com/articles/log-runtime-metrics
 
require 'heroku-api'
require 'open-uri'
require 'pony'
require 'keen'

web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
 
STDOUT.sync = true
app_name = ENV['MONITOR_APP_NAME']
 
puts "[monitor] Starting to monitor #{app_name}"
 
# you can delete/replace all this stats stuff if you aren't using Keen
class SafeStats
  attr_accessor :client
 
  def initialize
    self.client = Keen::Client.new(:project_id => ENV['KEEN_PROJECT_ID'], :write_key => ENV['KEEN_WRITE_KEY'], :read_key => ENV['KEEN_READ_KEY'])
  end
 
  def method_missing(name, *args, &blk)
    client.send(name, *args, &blk)
  rescue Keen::HttpError => ex
    puts "[monitor] Keen::HttpError during Stats #{name}(#{args.join(", ")})"
    puts "[monitor] #{ex.message}"
  end
end
 
STATS = SafeStats.new
 
begin
  API_KEY=ENV['HEROKU_API_KEY']
 
  heroku = Heroku::API.new(:api_key => API_KEY)
 
  # make sure this range will cover your web dynos.
  dynos = (1..1).to_a
 
  previous_timestamps = Hash.new(0)
  restarts = Hash.new
  while true
    begin
      puts "[monitor] Fetching log"
      response = open(heroku.get_logs(app_name, :ps => "web", 'num' => '1000').body).readlines.reverse.select{|l| l.include? "memory_total"}
    rescue => ex
      puts "[monitor] Unable to fetch log (#{ex.message})"
    end
 
    if response
      dynos.each do |i|
        restarts[i] ||= Time.now
        dyno_response = response.detect{|l| l.include? "[web.#{i}]"}
        next unless dyno_response
 
        size = dyno_response.match(/val=(\d*)/)[1]
        timestamp = dyno_response.match(/^(\d*)-(\d*)-(\d*)T(\d*):(\d*):(\d*)/)
 
        unless previous_timestamps[i].to_s == timestamp.to_s
          puts "[monitor] web.#{i} #{timestamp} dyno-size=#{size}MB"
          STATS.publish("monitor", {type: "dyno-size", process: "web.#{i}", timestamp: timestamp, size: size.to_i})
 
          if size.to_i > 1000 and (Time.now - restarts[i]) > 600
            restarts[i] = Time.now
            puts "RESTARTING WEB.#{i}" if size.to_i > 1000
            puts heroku.post_ps_restart(app_name, "ps" => "web.#{i}")
            STATS.publish("monitor", {type: "dyno-restart", reason: "memory-overflow", process: "web.#{i}", timestamp: timestamp})
          end
 
          previous_timestamps[i] = timestamp
        end
      end
    end
 
    sleep 10
  end
rescue SignalException => ex
  # SIGTERM is normal, we don't need an email about it
  raise ex unless ex.signm == 'SIGTERM'
rescue Exception => ex
  puts("MONITOR ERROR")
  puts(ex.class.to_s)
  puts(ex.message)
  puts(ex.backtrace.join("\n"))
 
  Pony.options = {
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
  m = Pony.mail(to: ENV['MONITOR_ALERT_EMAIL'], from: ENV['MONITOR_ALERT_EMAIL'], subject: "[monitor] fatal exception occurred", body: "#{ex.message}\n\n#{ex.backtrace.join("\n")}")
  puts m.inspect.to_s
end