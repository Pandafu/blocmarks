class IncomingMailer < ApplicationMailer

  def success(user, topic, bookmark)
    @user = user
    @topic = topic
    @bookmark = bookmark

    mail(to: @user.email, subject: "Success!")
  end

  def error(user, topic, bookmark)
    @user = user
    @topic = topic
    @bookmark = bookmark

    mail(to: @user.email, subject: "Failed!")
  end
end
