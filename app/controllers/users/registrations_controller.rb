# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token
  respond_to :json

  private

  def respond_with(resource, _opts={})
    if request.method == "POST" && resource.persisted?
      render json: {
        status: { code: 200, message: "signed in succesfully....." },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }, status: :ok
    elsif request.method == "DELETE"
      render json: {
        status: { code: 200, message: "Account deleted uccesfully....." }
      }, status: :ok
    else
      render json: {
        status: { code: 422, message: "User could not accessed ....#{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end


end
  # def respond_with(resource, _opts={})
  #   if request.method == "POST" && resource.persisted?
  #     token = JWT.encode({ user_id: resource.id }, ENV['DEVISE_JWT_SECRET_KEY'], 'HS256')
  #     render json: {
  #       status: { code: 200, message: "signed in succesfully....." },
  #       data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
  #       token: token
  #     }, status: :ok

  #   elsif request.method == "DELETE"
  #     render json: {
  #       status: { code: 200, message: "Account deleted uccesfully....." }
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: { code: 422, message: "User could not accessed ....#{resource.errors.full_messages.to_sentence}" }
  #     }, status: :unprocessable_entity
  #   end
  # end
# end
