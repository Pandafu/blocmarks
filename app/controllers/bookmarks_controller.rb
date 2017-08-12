class BookmarksController < ApplicationController
  before_action :find_bookmark, only: [:show, :edit, :update, :destroy]

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new
  end

  def edit
    
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.new(bookmark_params)

    if @bookmark.save
      flash[:notice] = "saved!"
      redirect_to topic_bookmark_path(@topic, @bookmark)
    else
      flash[:alert] = "error!"
      render new_topic_bookmark_path(@topic, @bookmark)
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      flash[:notice] = "Updated!"
      redirect_to @bookmark
    else
      flash[:alert] = "Error!"
      render edit_topic_bookmark_path(@topic, @bookmark)
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])

    @bookmark.destroy
    flash[:notice] = "destroyed!"
    redirect_to topic_path(@bookmark.topic)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url, :topic_id)
  end

  def find_bookmark
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end
end
