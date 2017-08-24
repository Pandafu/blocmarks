class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
  # Take a look at these in your server logs
  # to get a sense of what you're dealing with.
    puts "INCOMING PARAMS HERE: #{params}"

  # You put the message-splitting and business
  # magic here.
  # Find the user by using params[:sender]
  # Find the topic by using params[:subject]
  # Assign the url to a variable after retreiving it from params["body-plain"]
    @sender = params[:sender]
    @user = User.find_by_email(@sender)
    @title = params[:subject]
    @dbTopic = @user.topics.where(:title => @subject).first
    @url = params["body-plain"]

# Check if user is nil, if so, create and save a new user
# Check if the topic is nil, if so, create and save a new topic
# Now that you're sure you have a valid user and topic, build and save a new bookmark
    def create_topic
      @dbTopic = @user.topics.create(:title => @subject)
        if @dbTopic.save
          create_bookmark(@url)
        else
          puts "Topic not created"
          #TopicMailer.error(@user, @dbTopic).deliver
        end
      end

      def create_bookmark
        @bookmark = @dbTopic.bookmarks.create(:url => @url)
        if @bookmark.save
          puts "bookmark created"
          #Bookmark.success(@user, @dbTopic, @bookmark).deliver
        else
          puts "bookmark not created"
          #BookmarkMailer.error(@user, @dbTopic, @bookmark).deliver
        end
      end

    if @user != nil
      if @dbTopic != nil
        puts "topic exists"
        create_bookmark(@url)
      else
        puts "topic doesn't exist"
        create_topic(@dbTopic, @url)
      end
    else
      @randomPassword = Devise.friendly_token.first(8)
      @user = User.create!(:email => @sender, :password => @randomPassword)
      if @user.save
        puts "user created"
        create_topic(@dbTopic, @url)
      else
        puts "usermailer not created"
        #UserMailer.error(@user).deliver
      end
    end
    head 200
  end
end
