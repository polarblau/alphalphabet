#\ -p 4000

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'serve'
require 'serve/rack'

# The project root directory
root = ::File.dirname(__FILE__)

if ENV['RACK_ENV'] != 'production'
  
  require 'haml'
  class Haml::Engine
    alias old_initialize initialize
    def initialize(lines, options)
      options.update(:format => :html5)
      old_initialize(lines, options)
    end
  end
  
  require 'sass'
  require 'sass/plugin/rack'
  use Sass::Plugin::Rack
  Sass::Plugin.add_template_location(root + '/stylesheets/')
  
  require 'rack/coffee'
  use Rack::Coffee, {
    :root => root,
    :urls => '/javascripts/'
  }
end

# Other Rack Middleware
use Rack::ShowStatus      # Nice looking 404s and other messages
use Rack::ShowExceptions  # Nice looking errors

# Rack Application
if ENV['SERVER_SOFTWARE'] =~ /passenger/i
  # Passendger only needs the adapter
  run Serve::RackAdapter.new(root + '/views')
else
  # Use Rack::Cascade and Rack::Directory on other platforms for static assets
  run Rack::Cascade.new([
    Serve::RackAdapter.new(root + '/views'),
    Rack::Directory.new(root + '/public')
  ])
end


