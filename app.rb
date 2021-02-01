# frozen_string_literal: true

require 'sinatra'

class MMBB < Sinatra::Base
  get '/' do
    'Hello World!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
