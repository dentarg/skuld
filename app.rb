require 'sinatra/base'
require 'haml'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'skuld'
require 'google_spreadsheet'

class AppController < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    'skuld'
  end

  get '/test' do
    people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Patrik', 'Alla'],
      ['Bregott',   12.0, 'Johan', 'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan', 'Patrik, Roy'],
    ]

    skuld = Skuld.new(people, costs)

    @title = 'test'
    @debts = skuld.all_debts

    haml :debts
  end

  get '/:key' do |key|
    spreadsheet = GoogleSpreadsheet.new(key)
    skuld       = Skuld.new(spreadsheet.people, spreadsheet.costs)

    @title = spreadsheet.title
    @debts = skuld.all_debts

    haml :debts
  end
end
