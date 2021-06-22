class PasswordMailer < ApplicationMailer

  def confirmation
    @user=params[:user]
    @url = params[:url]

    mail(to: @user.email, subject: "Confirmação de conta")
  end
end
