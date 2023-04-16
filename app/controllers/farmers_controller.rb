class FarmersController < ApplicationController
  load_and_authorize_resource
  before_action :set_farmer, only: [:show, :edit, :update, :overview]

  def index
    @q = Farmer.ransack(params[:q])
    @farmers = @q.result(distinct: true)
  end

  def show
    @user = @farmer.user
  end

  def new
    @farmer = Farmer.new
    @farmer.plots.build
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

  def overview
    @user = @farmer.user
    @posts = @farmer.posts
    @experiences = @farmer.experiences.includes(:schedules) 
  end
  
  private

  def farmer_params
    params.require(:farmer).permit(:name, :prefecture_id, :address, :latitude, :longitude, :phone_number, :product, :website, :image, :profile, plots_attributes: [:id, :name, :_destroy])
  end

  def set_farmer
    @farmer = Farmer.find(params[:id])
  end
end