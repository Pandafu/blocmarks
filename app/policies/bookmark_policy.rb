class BookmarkPolicy < ApplicationPolicy
  attr_reader :user, :bookmark

  def initialize(user, bookmark)
    @user = user
    @bookmark = bookmark
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (bookmark.topic.user == user)
  end

  def destroy?
    user.present? && (bookmark.topic.user == user)
  end

end
