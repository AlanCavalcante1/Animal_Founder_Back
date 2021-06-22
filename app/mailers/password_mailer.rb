class PasswordMailer < ApplicationMailer

  def confirmation
    @user=params[:user]
    

    mail(to: @user.email, subject: "Confirmação de conta")
  end
end
