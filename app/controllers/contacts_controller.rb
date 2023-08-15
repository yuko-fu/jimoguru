class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      # メール送信処理を呼び出す
      ContactMailer.contact_mail(@contact).deliver_now
      flash[:success] = 'お問い合わせが送信されました。'
      redirect_to new_contact_path
    else
      render 'new'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end
