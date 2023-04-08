class FarmersController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_general, only: [:show, :edit, :update, :destroy]
  # before_action :check_general_existence, only: [:new, :create] 

  def index
    @farmers = Farmer.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
  
  def destroy
  end

  private

  # def general_params
  #   params.require(:general).permit(:prefecture_id, :address)
  # end

  # def set_general
  #   @general = General.find(params[:id])
  # end
end
