class Api::UsersController < ApplicationController
  def index
    render json: User.all, status: :ok
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created

      UserMailer.welcome_user(user).deliver
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: User.find(params[:id])
  end

  def update
    if current_user
      user = User.find(current_user.id)
      user.update(user_params)
      render json: user, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end

  def update_password
    user = User.find_by(reset_password_token: user_params[:reset_password_token])
    if user
      user.update(reset_password_token: nil, password: user_params[:password])
      render json: user, status: :ok
    else
      render json: {}, status: :bad_request
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :reset_password_token, :password, :password_confirmation)
  end

  def current_user
    return nil unless params[:auth_token]
    User.find_by authentication_token: params[:auth_token]
  end
end
