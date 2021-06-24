class PasswordController < ApplicationController
  def forgot
    if params[:email].blank? 
      return render json: {error: 'Operação inválida'}, status: :404
    end
    user = User.find_by(email: params[:email]) 
    if user.present?
      user.save if user.generate_password_token
      PasswordMailer.with(user: user, url: request.base_url).forgot.deliver_now
      render json: {status: 'ok'}, status: 200
    else
      render json: {error: 'Email não encontrado. Por favor, faça um cadastro.'}, status: :404
    end
  end

  def reset
    token = params[:token]
    if params[:token].blank?
        return render json: {error: 'Operação invalida'}
    end
    user = User.find_by(validation_token: token)
    if user.present? && user.is_token_valid?
      if user.reset_password!(params[:password], params[:password_confirmation])
        PasswordMailer.with(user: user).reset.deliver_now
        render json: {status: 'ok'}, status: :ok
      else
        render json: {error: "Nao foi possivel trocar de senha, tente novamente mais tarde"}, status: :unprocessable_entity
      end
    else
      render json: {error:  'Link não é valido ou expirou. Tente novamento com um novo link.'}, status: :404
    end 
  end

  
end
