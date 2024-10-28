module Api
  module V1
    module Students
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_enrollment, only: [ :destroy ]

        # Student Can create an Enrollment
        # Student Can delete his Enrollment in one week from he enrolled

        def create
          @enrollment = Enrollment.new(enrollment_params.merge(user_id: current_user.id))
          if @enrollment.save
            render json: {
              message: 'Your enrollment was created',
              data: @enrollment.as_json
            }, status: :ok
          else
            render json: {
              errors: render_errors(@enrollment)
            }, status: :unprocessable_entity
          end
        end

        def destroy
          # Check if the enrollment was created within the last week
          if @enrollment.created_at > 1.week.ago
            @enrollment.destroy
            render json: {
              message: 'Your enrollment was destroyed'
            }, status: :ok
          else
            render json: {
              message: 'Enrollment can no longer be canceled, as the allowed timeframe has passed.'
            }, status: :forbidden
          end
        end

        private

        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
        end

        def enrollment_params
          params.require(:enrollment).permit(:course_id, :grade)
        end

      end
    end
  end
end