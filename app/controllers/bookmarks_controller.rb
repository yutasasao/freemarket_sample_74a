class BookmarksController < ApplicationController

  def index
    @user = current_user
    @bookmarks = Bookmark.where(user_id: @user.id).all
  end

  def create
    bookmark = current_user.bookmarks.build(item_id: params[:item_id])
    bookmark.save!
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.bookmarks.find_by(item_id: params[:item_id]).destroy!
    redirect_back(fallback_location: root_path)
  end
end
