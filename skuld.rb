require 'sinatra/base'
require 'haml'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'debts'
require 'debts_helper'
require 'google_spreadsheet'

class Skuld < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  configure :production do
    require 'newrelic_rpm'
  end

  get '/' do
    haml :index
  end

  get '/favicon.ico' do
  end

  get '/test' do
    @people = %w(Patrik Johan Roy)
    costs  = [
      ['Ballerina', 30.0, 'Patrik', 'Alla'],
      ['Bregott',   12.0, 'Johan', 'Patrik, Johan, Roy'],
      ['Bärkasse',  50.0, 'Johan', 'Patrik, Roy'],
    ]

    debts = Debts.new(@people, costs)

    @title = 'test'
    @debts = debts.all_debts

    haml :debts
  end

  get '/:key' do |key|
    spreadsheet = GoogleSpreadsheet.new(key)
    @people     = spreadsheet.people
    skuld       = Debts.new(@people, spreadsheet.costs)

    @title = spreadsheet.title
    @debts = skuld.all_debts

    haml :debts
  end
end
