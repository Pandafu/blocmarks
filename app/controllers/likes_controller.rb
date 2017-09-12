class LikesController < ApplicationController
  def index
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)
    authorize like

    if like.save
      flash[:notice] = "liked!"
      redirect_to topic_bookmark_path(@bookmark.topic.id, @bookmark)
    else
      flash[:alert] = "error!"
      redirect_to topic_bookmark_path(@bookmark.topic.id, @bookmark)
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])
    authorize like

    if like.destroy
      flash[:notice] = "successful!"
      redirect_to topic_bookmark_path(@bookmark.topic.id, @bookmark)
    else
      flash[:alert] = "error!"
      redirect_to topic_bookmark_path(@bookmark.topic.id, @bookmark)
    end
  end
end
