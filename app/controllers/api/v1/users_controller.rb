class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      user.api_keys.create!(token: SecureRandom.hex(16))
      render json: UserSerializer.new(user), status: 201
    else
      render json: { error: user.errors.full_messages.to_sentence }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end