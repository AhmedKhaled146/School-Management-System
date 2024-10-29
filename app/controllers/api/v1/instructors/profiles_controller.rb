module Api
  module V1
    module Instructors
      class ProfilesController < ApplicationController
        before_action :authenticate_user!

        # He Can See his Data.
        # He Can Update his Data.

        def show
          render json: {
            user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
          }, status: :ok
        end

        def update
          if current_user.update(profile_params)
            render json: {
              user: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
            }
          else
            render json: {
              errors: render_errors(current_user)
            }, status: :unprocessable_entity
          end
        end

        private

        def profile_params
          params.permit(:first_name, :last_name, :phone, :age)
        end
      end
    end
  end
end

