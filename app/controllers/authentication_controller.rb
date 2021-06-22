class AuthenticationController < ApplicationController

  def confirm
    if params[:validation_token].present?

      @user = User.find_by(validation_token: params[:validation_token])
      if @user.present?
        if @user.validate_user?(params[:validation_token])
          render json: @user
        else 
          render json: {error: "Esse token já expirou"}, status: 422
        end

      else
        render json: {error: "Usuário não existe"}, status: 404
      end

    else
      render json: {error: "token não presente"}, status: 400
    end
  end

  def repeat_validation_token
    @user = User.find_by(email: params[:email])
    if @user.present?
      if @user.generation_validation_token
        PasswordMailer.with(user: @user, url: request.base_url).confirmation.deliver_now
        render json: {status: "Ok"}
      end
    else
      render json: {error: "Email não encontrado"}
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :cellphone, :password, :password_confirmation)
    end
end
