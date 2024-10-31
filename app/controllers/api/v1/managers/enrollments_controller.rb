module Api
  module V1
    module Managers
      class EnrollmentsController < ApplicationController
        before_action :authenticate_user!
        before_action :set_department
        before_action :set_manager

        # He Can See All Enrollment Details in his Department.

        def index
          response = @department.courses.includes(:enrollments, :students).map do |course|
            {
              course_name: course.name,
              students: course.enrollments.map { |enrollment|
                enrollment.student.name
              }
            }
          end

          render json: {
            department: @department.name,
            courses_with_enrollments: response,
            message: "All Enrollments in #{@department.name} Department Fetched Successfully"
          }, status: :ok
        end

        private

        def set_department
          @department = Department.find(params[:department_id])
        rescue ActiveRecord::RecordNotFound
          record_not_found('Department')
        end

        def set_manager
          unless @department.manager_id == current_user.id
            user_not_authorized
          end
        end
      end
    end
  end
end
