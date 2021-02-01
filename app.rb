# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'



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
    @listing = session['name']
    erb :'listings/index'
  end

  get '/listings/add' do
    erb :'listings/add'
  end

  post '/listings' do
    session['name'] = params['name']
    redirect('/listings')
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
