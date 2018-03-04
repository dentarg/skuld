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

  get '/' do
    haml :index
  end

  get '/favicon.ico' do
  end

  get '/:key' do |key|
    if key == 'test'
      @people = %w(Patrik Johan Roy)
      @title  = 'test'
      costs  = [
        ['Ballerina', 30.0, 'Patrik', 'Alla'],
        ['Bregott',   12.0, 'Johan', 'Patrik, Johan, Roy'],
        ['Bärkasse',  50.0, 'Johan', 'Patrik, Roy'],
      ]
    else
      spreadsheet = GoogleSpreadsheet.new(key)
      costs       = spreadsheet.costs
      @title      = spreadsheet.title
      @people     = spreadsheet.people
    end

    skuld         = Debts.new(@people, costs)
    @debts        = skuld.all_debts
    @balances     = DebtsHelper.balances(debts: @debts, people: @people)
    @transactions = DebtsHelper.all_transactions(debts: @debts, people: @people)

    haml :debts
  end
end
