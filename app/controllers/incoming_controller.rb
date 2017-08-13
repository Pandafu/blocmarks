class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    puts "INCOMING PARAMS HERE: #{params}"

    sender = params[:sender]
    puts "rocket#{sender}"

    head 200
  end
end
