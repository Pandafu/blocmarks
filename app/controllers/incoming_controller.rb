class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
  #  puts "INCOMING PARAMS HERE: #{params}"

    @sender = params[:sender]
  #  puts "rocket#{sender}"
    @title = params[:subject]
    @url = params["body-plain"]

    if User.find_by_email(@sender)
      #save bookmark
    else
      User.create!()
    end

    head 200
  end
end
