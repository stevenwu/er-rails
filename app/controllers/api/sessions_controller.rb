class Api::SessionsController < ApplicationController
  def create
    return missing_params unless (params[:email] && params[:password])

    user = user_from_credentials
    return invalid_credentials unless user

    data = {
      user_id: user.id,
      user: user,
      auth_token: user.authentication_token
    }

    render json: data, status: :created
  end

  def destroy
    return missing_params unless params[:auth_token]

    user = User.find_by authentication_token: params[:auth_token]
    return invalid_credentials unless user

    user.reset_authentication_token!

    render json: { user_id: user.id, status: :ok }
  end

  private

  def user_from_credentials
    if user = User.find_for_database_authentication(email: params[:email])
      if user.valid_password? params[:password]
        user
      end
    end
  end

  def missing_params
    render json: {}, status: :bad_request
  end

  def invalid_credentials
    render json: {}, status: :unauthorized
  end
end
