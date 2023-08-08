class Api::V1::SessionsController < ApplicationController
  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        render json: UserSerializer.new(user), status: 200
      else
        render json: { error: 'Invalid credentials' }, status: :bad_request
      end
    else
      render json: { error: 'Invalid credentials' }, status: :bad_request
    end
  end
end