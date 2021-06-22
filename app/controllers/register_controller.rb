class RegisterController < ApplicationController
  def sign_up
    @user = User.new(user_params)
    byebug
    if @user.save
      PasswordMailer.with(user: @user, url: request.base_url).confirmation.deliver_now
      render json: {user: UserSerializer.new(@user)}, status: 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :cellphone, :password, :password_confirmation)
    end
end
