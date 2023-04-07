class GeneralsController < ApplicationController 
  before_action :authenticate_user!, only: [:new, :create]
  # before_action :check_general_existence, only: [:new, :create] 

  def new
    @general = General.new
  end

  def create
    @general = General.new(general_params)
    @general.user = current_user
    if @general.save
      redirect_to root_path, notice: "プロフィールが登録されました。"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private

  def general_params
    params.require(:general).permit(:prefecture_id, :address)
  end

  # def check_general_existence
  #   if current_user.general.present?
  #     flash[:alart] = "既にプロフィールが登録されています"
  #     redirect_to  new_user_session_path
  #   end
  # end
  
  def set_general
  end
end
