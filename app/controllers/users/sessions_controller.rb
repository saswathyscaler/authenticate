# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  private

  def respond_with(resource, _opts={})
    render json:{
      status: {code:200, message: "Logged in succesfully....."},
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end
  
  def respond_to_on_destroy
    if current_user
      render json:{
        status: 200,
        message: "Logged out succesfully....."
      }, status: :ok
    else
      render json:{
        status: 401,
        message: "Could not find any active sesssion."
      }, status: :unauthorized
    end
  end
end




  # def respond_with(resource, _opts={})
  #   if request.method == "POST" && resource.persisted?
  #     token = JWT.encode({ user_id: resource.id }, ENV['DEVISE_JWT_SECRET_KEY'], 'HS256')
  #     render json: {
  #       status: { code: 200, message: "Logged in succesfully....." },
  #       data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
  #       token: token
  #     }, status: :ok
  #   end
  # end
  