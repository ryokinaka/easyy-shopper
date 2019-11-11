class ItemsController < ApplicationController
  before_action :require_user_logged_in
    
  def index
    if logged_in?
      @items = Item.all.order(id: :desc).page(params[:page]).per(20)

      if params[:category].present?
        @items = Item.page(params[:page]).per(20).get_by_category params[:category]
      end
    end
  end
    
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
      render 'items/index'
    end
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    @item = Item.find(params[:id])
    
    if @item.update(item_params)
      flash[:success] = 'アイテム情報を更新しました'
      redirect_to @item
    else
      flash.now[:danger] = 'アイテム情報の更新に失敗しました'
      render :edit
    end
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    
    flash[:success] = 'アイテムを削除しました'
    redirect_to root_url
  end
  
  def purchase
    @item = Item.find(params[:id])
  end
  
  def done
    @item = Item.find(params[:id])
    @item.buyers.create(
      user: current_user
    )
    @item.update(category: 'その他', buying: 'soldout')
  end
  
  def buylist
    @buyer = current_user.buyers.all.order(id: :desc).page(params[:page]).per(10)
  end
  
  def selllist
    @item = current_user.items.all.order(id: :desc).page(params[:page]).per(10)
  end
  
  private
  
  def item_params
    params.require(:item).permit(:image, :title, :category, :price, :explanation, :buying, :condition, :shipping, :region, :day)
  end
end
