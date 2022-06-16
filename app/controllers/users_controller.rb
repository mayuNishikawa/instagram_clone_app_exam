class UsersController < ApplicationController

  skip_before_action :login_required, only: %i[ new create ]
  before_action :ensure_current_user, only: %i[ edit update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :profile, :email, :password, :password_confirmation)
  end

  def ensure_current_user
    unless @picture.user == current_user
      flash[:notice]="you don't have authority"
      redirect_to pictures_path
    end
  end
end
