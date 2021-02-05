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
require 'webdrivers'

class MMBB < Sinatra::Base
  # configure :development do
  #   register Sinatra::Reloader
  # end

  register Sinatra::Flash

  enable :sessions
  enable :method_override

  before do 
    @user = session[:user]
  end

  get '/' do
    'Hello World!'
    redirect('/listings')
  end

  get '/listings' do
    @listings = Listing.all
    # @user = session[:user]
    @new_booking = true
    flash.now[:notice] = %Q[<a href="/users/#{@user.id}/listings">One of your listings has a new booking</a>] if @user
    erb :'listings/index'
  end

  get '/listings/add' do
    # @user = session[:user]
    erb :'listings/add'
  end

  post '/listings' do
    Listing.create(name: params[:name], description: params[:description], price_per_night: params[:price_per_night], user_id: session[:user].id)
    redirect('/listings')
  end

  get '/listings/:id' do
    @listing = Listing.find(id: params[:id])
    @host = User.find(id: @listing.user_id)
    # @user = session[:user]
    erb :'listings/specific_listing'
  end

  patch '/bookings/:id' do
    if params[:choice] == "Approve"
      Booking.update(id: params[:id], status: "accepted")
    elsif params[:choice] == "Deny"
      Booking.update(id: params[:id], status: "denied")
    end
    redirect "/users/#{session[:user].id}/listings"
  end

  post '/bookings' do
    Booking.create(listing_id: params[:listing_id], visitor_id: session[:user].id, status: 'pending')
    redirect "/users/#{session[:user].id}/bookings"
  end

  get '/users/:id/bookings' do
    @bookings = Booking.where(field: "visitor", id: session[:user].id)
    @listings = @bookings.map { | booking | Listing.find(id: booking.listing_id) }
    # @user = session[:user]
    erb :'bookings/index'
  end

  get '/users/:id/listings' do
    # @user = session[:user]
    @listings = Listing.where(user_id: @user.id)
    @bookings = Hash.new
    @listings.each { |listing| @bookings[listing.id] = Booking.where(field: "listing", id: listing.id) }
    erb :'users/my_listings'
  end

  get '/users/new' do
    erb :'users/new'
  end

  post '/users' do
    session[:user] = User.create(name: params[:name], email: params[:email_new], username: params[:username], password: params[:password_new])

    case session[:user]
    when "duplicate email"
      flash[:notice] = "This email address has already been taken"
      session[:user] = nil
      redirect '/users/new'
    when "duplicate username"
      flash[:notice] = "This username has already been taken"
      session[:user] = nil
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
