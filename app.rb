require 'sinatra/base'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

class AppController < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  get '/' do
    'skuld'
  end
end
