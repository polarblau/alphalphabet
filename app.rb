#!/usr/bin/env ruby
# Usage: ruby app.rb -e production

require 'rubygems'
require 'sinatra'
require 'haml'

require File.dirname(__FILE__) + '/lib/alphalphabet.rb'

alphalphabet = AlphAlphaBet.new

get '/' do
  @letter = alphalphabet.say_letter
  haml :index
end

get '/stylesheet.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :stylesheet
end

# use_in_file_templates!

__END__
@@ index
!!!
%html
  %head
    %title= "AlphAlphaBet | #{@letter}"
    %meta{'http-equiv' => 'Content-Type', :content => 'text/html; charset=utf-8'}
    %link{:rel => 'stylesheet', :href => '/stylesheet.css', :type => 'text/css'}
  %body
    %h1= @letter

@@ stylesheet
body
  padding: 0 5em
  margin: 0
  background: white
  color: #333
  text-align: center
  height: 100%
  font: 1.5em Helvetica, sans-serif
h1
  font-size: 20em
  line-height: 100%