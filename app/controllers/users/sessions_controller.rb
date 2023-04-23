class Users::SessionsController < Devise::SessionsController
  def guest_admin_sign_in
    sign_in User.guest_admin
    redirect_to root_path, notice: 'ゲスト(管理者)としてログインしました。'
  end

  def guest_farmer_nil_sign_in
    sign_in User.guest_farmer_nil
    redirect_to root_path, notice: 'ゲスト(農家/プロフィール登録なし)としてログインしました。'
  end

  def guest_farmer_present_sign_in
    sign_in User.guest_farmer_present
    redirect_to root_path, notice: 'ゲスト(農家/プロフィール登録あり)としてログインしました。'
  end

  def guest_general_present_sign_in
    sign_in User.guest_general_present
    redirect_to root_path, notice: 'ゲスト(一般の方/プロフィール登録あり)としてログインしました。'
  end

  def guest_general_nil_sign_in
    sign_in User.guest_general_nil
    redirect_to root_path, notice: 'ゲスト(一般の方/プロフィール登録なし)としてログインしました。'
  end
end