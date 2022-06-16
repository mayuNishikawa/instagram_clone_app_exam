class PicturesController < ApplicationController

  before_action :set_picture, only: %i[ show edit update destroy ]
  before_action :ensure_current_user, only: %i[ edit update destroy ]

  def index
    @pictures = Picture.all.order("created_at DESC")
    @favorite = current_user.favorites.find_by(params[:id])
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    render :new and return if params[:back]
    if @picture.save
      ContactMailer.contact_mail(@picture).deliver
      redirect_to pictures_path
    else
      render :new
    end
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_url
    else
      render :edit
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_url
  end

  private
  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:image, :content, :user_id)
  end

  def ensure_current_user
    unless @picture.user == current_user
      flash[:notice]="you don't have authority"
      redirect_to pictures_path
    end
  end
end
