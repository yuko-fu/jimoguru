class UsersController < ApplicationController

  def show
    @votes = Vote.where(user_id:current_user.id)
  end


  def confirm_withdraw
  end

  def withdraw
    if current_user.update(is_valid: false)
      sign_out current_user
      redirect_to root_path, notice: "退会が完了しました。"
    else
      redirect_to root_path, alert: "退会処理に失敗しました。"
    end
  end

  def reject_inactive_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        redirect_to new_user_session_path
      end
    end
  end
end
