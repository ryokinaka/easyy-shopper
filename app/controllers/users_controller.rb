class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :likes]
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def likes
    @user = User.find(params[:id])
    @wantings = @user.wantings.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :address, :password, :password_confirmation)
  end
end
