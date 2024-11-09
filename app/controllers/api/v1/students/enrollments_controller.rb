module Api
  module V1
    module Students
      class EnrollmentsController < ApplicationController

        before_action :authenticate_user!
        before_action :set_enrollment, only: [ :show, :destroy ]

        # Student can create an enrollment
        # Student can delete enrollment within one week of creation

        def index
          enrollments = policy_scope(current_user.enrollments.includes(:course))
          response = format_enrollments_with_grades(enrollments)
          render json: response, status: :ok
        end

        def show
          authorize @enrollment
          render json: {
            enrollment: @enrollment,
            message: "Enrollment Fetched Successfully"
          }, status: :ok
        end

        def create
          @enrollment = Enrollment.new(enrollment_params.merge(user_id: current_user.id))
          authorize @enrollment
          if @enrollment.save
            render json: {
              message: 'Your enrollment was created successfully.',
              data: @enrollment
            }, status: :created
          else
            render_errors(@enrollment)
          end
        end

        def destroy
          @enrollment = Enrollment.find(params[:id])
          authorize @enrollment, :destroy?

          @enrollment.destroy
          render json: {
            message: 'Your enrollment was successfully canceled.'
          }, status: :ok
        rescue Pundit::NotAuthorizedError
          render json: {
            message: 'Enrollment can no longer be canceled, as the allowed timeframe has passed.'
          }, status: :forbidden
        end


        private

        def format_enrollments_with_grades(enrollments)
          enrollments.map do |enrollment|
            {
              course_name: enrollment.course.name,
              enrollment_date: enrollment.created_at,
              grade: enrollment.grade
            }
          end
        end

        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
          authorize @enrollment
        rescue ActiveRecord::RecordNotFound
          render json: { message: 'Enrollment not found.' }, status: :not_found
        end

        def enrollment_params
          params.require(:enrollment).permit(:course_id)
        end
      end
    end
  end
end
