# frozen_string_literal: true

class Users::PasswordsController < Devise::PasswordsController
  before_action :ensure_normal_user, only: :create

  def ensure_normal_user
    if params[:user][:email][:prefecture].downcase == 'guest@example.com'
      redirect_to shops_path, alert: 'ゲストユーザーのパスワード、都道府県の再設定はできません。'
    end
  end
  def ensure_normal_admin_user
    if params[:user][:email][:prefecture].downcase == 'guest_admin@example.com'
      redirect_to shops_path, alert: 'ゲストユーザーのパスワード、都道府県の再設定はできません。'
    end
  end
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  # def create
  #   super
  # end

  # GET /resource/password/edit?reset_password_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/password
  # def update
  #   super
  # end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
