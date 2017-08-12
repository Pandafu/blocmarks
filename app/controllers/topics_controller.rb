class TopicsController < ApplicationController
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.new(topic_param)

    if @topic.save
      flash[:notice] = "Created!"
      redirect_to @topic
    else
      flash[:alert] = "error!"
      render @topic
    end
  end

  def destroy
    @topic = Topic.find(params[:id])

    @topic.destroy
      flash[:alert] = "destroy!"
      redirect_to topics_path
  end


  private

  def topic_param
    params.require(:topic).permit(:title, :user_id)
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end
end
