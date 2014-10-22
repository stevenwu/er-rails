class Api::PasswordResetController < ApplicationController
  def create
    User.find_by_email!(user_params[:email]).send_reset_password_instructions

    render json: { status: 'ok'}, status: :ok
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
