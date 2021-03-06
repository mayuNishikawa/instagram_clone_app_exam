class UsersController < ApplicationController

  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ show edit update ]
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
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:image, :name, :profile, :email, :password, :password_confirmation)
  end

  def ensure_current_user
    unless @user == current_user
      flash[:notice]="you don't have authority"
      redirect_to pictures_path
    end
  end
end
