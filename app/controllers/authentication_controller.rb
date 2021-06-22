class AuthenticationController < ApplicationController

  def sign_up
    @user = User.new(user_params)
    if @user.save
      PasswordMailer.with(user: @user, url: request.base_url).confirmation.deliver_now
      render json: {user: UserSerializer.new(@user)}, status: 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:user][:email])
    user = user&.authenticate(params[:user][:password])

    if user
      token = JsonWebToken.encode(user_id: user.id)
      render json: {token: token, user: UserSerializer.new(user)}
    else
      render json: {message: "Nao foi possovel fazer login"}, status: 401
    end
  end

  #def confirm
  #  if params[:validation_token].present?

  #    @user = User.find_by(validation_token: params[:validation_token])
  #    if @user.present?
  #      if @user.validate_user?(params[:validation_token])
  #        render json: @user
  #      else 
  #        render json: {error: "Esse token já expirou"}, status: 422
  #      end

  #    else
  #      render json: {error: "Usuário não existe"}, status: 404
  #    end

  #  else
  #    render json: {error: "token não presente"}, status: 400
  #  end
  #end

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
