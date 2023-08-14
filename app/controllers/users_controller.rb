class UsersController < ApplicationController

  def show
    @votes = Vote.where(user_id:current_user.id)
  end

end
