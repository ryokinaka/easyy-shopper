class ItemsController < ApplicationController
  before_action :require_user_logged_in
  
  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = '出品登録が完了しました。'
      redirect_to root_url
    else
      @items = current_user.items.order(id: :desc).page(params[:page])
      flash.now[:danger] = '出品登録ができませんでした。'
      render 'toppages/index'
    end
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :title, :category, :price, :explanation)
  end
  
  def correct_user
    @item = current_user.items.find_by(id: params[:id])
    unless @item
      redirect_to root_url
    end
  end
end
