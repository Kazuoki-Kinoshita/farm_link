class FarmersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_farmer, only: [:show, :edit, :update, :destroy]
  # before_action :check_general_existence, only: [:new, :create] 

  def index
    @farmers = Farmer.all
  end

  def show
    @user = @farmer.user
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
  end
  
  def destroy
  end

  private

  def farmer_params
    params.require(:farmer).permit(:name, :prefecture_id, :address, :latitude, :longitude, :phone_number, :product, :website, :image, :profile)
  end

  def set_farmer
    @farmer = Farmer.find(params[:id])
  end
end
