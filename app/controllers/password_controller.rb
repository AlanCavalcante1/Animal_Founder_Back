class PasswordController < ApplicationController
  def forgot
    if params[:email].blank? 
      return render json: {error: 'Operação inválida'}, status: :404
    end
    user = User.find_by(email: params[:email]) 
    if user.present?
      user.save if user.generate_password_token
      PasswordMailer.with(user: user).forgot.deliver_now
      render json: {status: 'ok'}, status: 200
    else
      render json: {error: 'Email não encontrado. Por favor, faça um cadastro.'}, status: :404
    end
  end
end
