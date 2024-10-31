module Api
  module V1
    module Users
      class ProfilesController < ApplicationController
        before_action :authenticate_user!

        def show
          render json: {
            profile: current_user,
            message: "Profile fetched successfully"
          }, status: :ok
        end

        def update
          if current_user.update(profile_params)
            render json: {
              message: "Profile updated successfully",
              profile: current_user
            }, status: :ok
          else
            render json: {
              errors: render_errors(current_user)
            }, status: :unprocessable_entity
          end
        end

        private

        def profile_params
          params.require(:user).permit(:first_name, :last_name, :phone, :age)
        end
      end
    end
  end
end
