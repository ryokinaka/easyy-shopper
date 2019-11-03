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
  
  def purchase
    @item = Item.find(params[:id])
  end
  
  def buying
    item = Item.find(params[:item_id])
    current_user.buy(item)
    flash[:success] = '購入手続きが完了しました'
    redirect_to done_item_path
  end
  
  def done
    @item = Item.find(params[:id])
    @item.buyers.create(
      user: current_user
    )
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :title, :category, :price, :explanation)
  end
end
