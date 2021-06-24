class SessionController < ApplicationController
  def login
    user = User.find_by(email: params[:user][:email])
    user = user&.authenticate(params[:user][:password])

    if user
      if user.is_valid == false
        return render json: {message: "Usuario não esta validado via email"}
      end
      token = JsonWebToken.encode(user_id: user.id)
      render json: {token: token, user: UserSerializer.new(user)}
    else
      render json: {message: "Email ou senha incorretos"}, status: 401
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
