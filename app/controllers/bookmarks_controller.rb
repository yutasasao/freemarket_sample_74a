class BookmarksController < ApplicationController

  def index
    @bookmarks = Bookmark.where(user_id: current_user.id)
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
