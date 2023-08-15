# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :authenticate_user!

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to shops_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def guest_admin_sign_in
    user = User.guest_admin
    sign_in user
    redirect_to shops_path, notice: 'ゲスト管理者としてログインしました。'
  end

  def destroy
    # セッションを破棄
    session[:user_id] = nil
    # ログアウト後にトップ画面にリダイレクト
    redirect_to root_path, notice: 'ログアウトしました'
  end

  # protected

  # def after_sign_in_path_for(resource)
  #   shops_path
  # end
  
end
