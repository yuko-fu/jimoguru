module ApplicationHelper
  def show_guest_login_buttons?
    !user_signed_in?
  end
end
