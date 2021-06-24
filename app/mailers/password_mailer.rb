class PasswordMailer < ApplicationMailer

  def confirmation
    @user = params[:user]
    @url = params[:url]

    mail(to: @user.email, subject: "Animal Founder - Confirmação de conta")
  end

  def forgot
    @user = params[:user]
    @url = params[:url]
    mail(to: @user.email, subject:"Animal Founder - Recuperação de Senha")
  end

  def reset
    @user = params[:user]

    mail( to: @user.email, subject: "Animal Founder - Mudança de senha")
  end


end
