class WantsController < ApplicationController
  def index
    @wants = Want.all.page(params[:page])
  end

  def create
    item = Item.find(params[:item_id])
    current_user.like(item)
    flash[:success] = '気になる物リストに追加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    item = Item.find(params[:item_id])
    current_user.unlike(item)
    flash[:success] = '気になる物リストから削除しました。'
    redirect_back(fallback_location: root_path)
  end
end
