# frozen_string_literal: true

require 'sinatra'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './database_setup'
require './lib/listing'
require './lib/user'
require './lib/booking'
require './lib/database_connection'


class MMBB < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  configure do
    set :public_dir, "public"
  end
  register Sinatra::Flash

  enable :sessions

  get '/' do
    'Hello World!'
    redirect('/listings')
  end

  get '/listings' do
    @listings = Listing.all
    @user = session[:user]
    erb :'listings/index'
  end

  get '/listings/add' do
    erb :'listings/add'
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price_per_night: params[:price_per_night], user_id: session[:user].id)
    redirect('/listings')
  end

  get '/listings/:id' do
    result = DatabaseConnection.query("select * from listing where id = #{params[:id]}").first
    @listing = Listing.new(id: result['id'],
                name: result['name'],
                description: result['description'],
                price_per_night: result['price_per_night'].to_i,
                user_id: result['user_id'])
    @host = User.find(id: @listing.user_id)
    erb :'listings/specific_listing'
  end

  post '/bookings' do
    Booking.create(listing_id: params[:listing_id], visitor_id: session[:user].id, status: 'pending')
    redirect '/bookings'
  end

  get '/bookings' do
    @bookings = Booking.find_all(by: "visitor", id: session[:user].id)
    listing_ids = @bookings.map { | booking | booking.listing_id }
    #@listings = listing_ids.map { | listing_id | Listings.find(listing_id: listing_id) }
    @listings = []
    listing_ids.each { | listing_id |
      result = DatabaseConnection.query("select * from listing where id = #{listing_id}").first
      @listings.push(Listing.new(id: result['id'],
                  name: result['name'],
                  description: result['description'],
                  price_per_night: result['price_per_night'].to_i,
                  user_id: result['user_id']))
    }

    erb :'bookings/index'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    session[:user] = User.create(name: params[:name], email: params[:email], username: params[:username], password: params[:password])

    case session[:user]
    when "duplicate email"
      flash[:notice] = "This email address has already been taken"
      redirect '/users/new'
    when "duplicate username"
      flash[:notice] = "This username has already been taken"
      redirect '/users/new'
    else
      redirect '/listings'
    end
  end

  post '/sessions' do
    session[:user] = User.authenticate(email: params[:email], password: params[:password])
    redirect('/listings')
  end

  post '/sessions/destroy' do
    session.clear
    redirect '/listings'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
