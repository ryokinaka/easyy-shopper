class ToppagesController < ApplicationController
  def index
    if logged_in?
      @items = Item.all.order(id: :desc).page(params[:page]).per(20)

      if params[:category].present?
        @items = Item.page(params[:page]).per(20).get_by_category params[:category]
      end
    end
  end
  
end