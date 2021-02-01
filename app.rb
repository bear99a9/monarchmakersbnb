# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/listing'
require './lib/database_connection'

class MMBB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    'Hello World!'
    redirect('/listings')
  end

  get '/listings' do
    @listings = Listing.all
    erb :'listings/index'
  end

  get '/listings/add' do
    erb :'listings/add'
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price_per_night: params[:price_per_night])
    redirect('/listings')
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
