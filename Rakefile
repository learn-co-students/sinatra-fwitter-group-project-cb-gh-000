ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "A basic Rake console"
task :console do

  Pry.start

end

desc "Create a spec.erb file"
task :create_spec do
  sh "rspec spec/controllers/application_controller_spec.rb --format html > app/views/spec.erb"
end

# Type `rake -T` on your command line to see the available rake tasks.
