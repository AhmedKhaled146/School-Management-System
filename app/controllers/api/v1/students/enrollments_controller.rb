module Api
  module V1
    module Students
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_enrollment, only: [ :destroy ]

        # Student can create an enrollment
        # Student can delete enrollment within one week of creation

        def create
          @enrollment = Enrollment.new(enrollment_params.merge(user_id: current_user.id))
          if @enrollment.save
            render json: {
              message: 'Your enrollment was created successfully.',
              data: @enrollment
            }, status: :created
          else
            render json: {
              errors: render_errors(@enrollment)
            }, status: :unprocessable_entity
          end
        end

        def destroy
          if enrollment_within_timeframe?
            @enrollment.destroy
            render json: { message: 'Your enrollment was successfully canceled.' }, status: :ok
          else
            render json: {
              message: 'Enrollment can no longer be canceled, as the allowed timeframe has passed.'
            }, status: :forbidden
          end
        end

        private

        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
          unless @enrollment.user_id == current_user.id
            render json: { message: 'Not authorized to access this enrollment.' }, status: :forbidden
          end
        rescue ActiveRecord::RecordNotFound
          render json: { message: 'Enrollment not found.' }, status: :not_found
        end

        def enrollment_within_timeframe?
          @enrollment.created_at > 1.week.ago
        end

        def enrollment_params
          params.require(:enrollment).permit(:course_id)
        end
      end
    end
  end
end
