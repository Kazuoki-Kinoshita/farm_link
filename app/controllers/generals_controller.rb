class GeneralsController < ApplicationController 
  load_and_authorize_resource
  before_action :set_general, only: [:show, :edit, :update, :destroy]

  def show
    @user = @general.user
  end

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    @general.user = current_user
    if @general.save
      redirect_to @general, notice: "プロフィールが登録されました。"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @general.update(general_params)
      redirect_to @general, notice: "プロフィールが更新されました。"
    else
      render :edit
    end
  end
  

  private

  def general_params
    params.require(:general).permit(:prefecture_id, :address, :image)
  end

  def set_general
    @general = General.find(params[:id])
  end
end