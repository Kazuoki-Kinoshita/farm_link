class FarmersController < ApplicationController
  load_and_authorize_resource
  before_action :set_farmer, only: [:edit, :update, :overview]
  # before_action :check_general_existence, only: [:new, :create] 

  def index
    @farmers = Farmer.all
  end

  def show
    @farmer = Farmer.find_by(id: params[:id])
    @user = current_user
  end

  def new
    @farmer = Farmer.new
  end

  def create
    @farmer = Farmer.new(farmer_params)
    @farmer.user = current_user
    if @farmer.save
      redirect_to @farmer, notice: "プロフィールが登録されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @farmer.update(farmer_params)
      redirect_to @farmer, notice: "プロフィールが更新されました。"
    else
      render :edit
    end
  end
  
  
  private

  def farmer_params
    params.require(:farmer).permit(:name, :prefecture_id, :address, :latitude, :longitude, :phone_number, :product, :website, :image, :profile)
  end

  def set_farmer
    @farmer = Farmer.find_by(id: params[:id])
  end
end