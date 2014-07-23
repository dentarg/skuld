require 'sinatra/base'
require 'haml'

$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'skuld'

class AppController < Sinatra::Base
  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  configure do
    enable :inline_templates
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

    @debts = skuld.all_debts

    haml :debts
  end
end

__END__

@@ layout
%html
  %head
    %title skuld
  %body
    = yield

@@ debts
%h1 all debts
%ul
  -@debts.each do |debt|
    %li= "#{debt[:sharer]} owes #{debt[:payer]} #{debt[:amount]}"
